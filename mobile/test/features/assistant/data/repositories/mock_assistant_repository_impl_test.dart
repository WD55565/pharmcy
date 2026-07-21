import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/result.dart';
import 'package:mobile/features/assistant/data/repositories/mock_assistant_repository_impl.dart';
import 'package:mobile/features/assistant/domain/entities/assistant_language.dart';
import 'package:mobile/features/assistant/domain/entities/chat_message.dart';
import 'package:mobile/features/pharmacy/domain/entities/pharmacy.dart';
import 'package:mobile/features/pharmacy/domain/repositories/pharmacy_repository.dart';

const _onDuty = Pharmacy(
  id: 1,
  name: 'Merkez Eczanesi',
  phone: '0212 111 11 11',
  address: 'Bağdat Caddesi No:1',
  district: 'Kadıköy',
  latitude: 40.99,
  longitude: 29.03,
  isOnDuty: true,
);

const _offDuty = Pharmacy(
  id: 2,
  name: 'Sahil Eczanesi',
  phone: '0212 222 22 22',
  address: 'Barbaros Bulvarı No:5',
  district: 'Beşiktaş',
  latitude: 41.04,
  longitude: 29.00,
  isOnDuty: false,
);

class _FakePharmacyRepository implements PharmacyRepository {
  _FakePharmacyRepository(this._result);

  final Result<List<Pharmacy>> _result;

  @override
  Future<Result<List<Pharmacy>>> getPharmacies() async => _result;

  @override
  Future<Result<Pharmacy>> getPharmacyById(int id) async {
    throw UnimplementedError('not used by the assistant');
  }
}

void main() {
  group('MockAssistantRepositoryImpl', () {
    test('answers an on-duty question with real pharmacy data, in English', () async {
      final repository = MockAssistantRepositoryImpl(
        _FakePharmacyRepository(Result.success([_onDuty, _offDuty])),
      );

      final reply = await repository.sendMessage(
        userMessage: 'which pharmacies are on duty right now?',
        history: const [],
        language: AssistantLanguage.english,
      );

      expect(reply.role, ChatMessageRole.assistant);
      expect(reply.content, contains('Merkez Eczanesi'));
      expect(reply.content, isNot(contains('Sahil Eczanesi')));
    });

    test('answers an on-duty question in Turkish when Turkish is selected', () async {
      final repository = MockAssistantRepositoryImpl(
        _FakePharmacyRepository(Result.success([_onDuty])),
      );

      final reply = await repository.sendMessage(
        userMessage: 'hangi eczaneler nöbetçi?',
        history: const [],
        language: AssistantLanguage.turkish,
      );

      expect(reply.content, contains('nöbetçi'));
      expect(reply.content, contains('Merkez Eczanesi'));
    });

    test('answers an on-duty question in Arabic when Arabic is selected', () async {
      final repository = MockAssistantRepositoryImpl(
        _FakePharmacyRepository(Result.success([_onDuty])),
      );

      final reply = await repository.sendMessage(
        userMessage: 'ما هي الصيدليات المناوبة؟',
        history: const [],
        language: AssistantLanguage.arabic,
      );

      expect(reply.content, contains('المناوبة'));
    });

    test('says nothing is on duty when the list has no on-duty pharmacies', () async {
      final repository = MockAssistantRepositoryImpl(
        _FakePharmacyRepository(Result.success([_offDuty])),
      );

      final reply = await repository.sendMessage(
        userMessage: 'on duty pharmacies?',
        history: const [],
        language: AssistantLanguage.english,
      );

      expect(reply.content, contains('No on-duty pharmacies'));
    });

    test('falls back to generic help text for an unrecognized question', () async {
      final repository = MockAssistantRepositoryImpl(
        _FakePharmacyRepository(Result.success(const [])),
      );

      final reply = await repository.sendMessage(
        userMessage: 'what is the weather today?',
        language: AssistantLanguage.english,
        history: const [],
      );

      expect(reply.content, contains('I can help with'));
    });

    test('answers an hours question without hitting the repository', () async {
      final repository = MockAssistantRepositoryImpl(
        _FakePharmacyRepository(Result.success(const [])),
      );

      final reply = await repository.sendMessage(
        userMessage: 'what are the opening hours?',
        history: const [],
        language: AssistantLanguage.english,
      );

      expect(reply.content, contains('hours'));
    });

    test('every reply has a unique id and an assistant role', () async {
      final repository = MockAssistantRepositoryImpl(
        _FakePharmacyRepository(Result.success(const [])),
      );

      final first = await repository.sendMessage(
        userMessage: 'hello',
        history: const [],
        language: AssistantLanguage.english,
      );
      final second = await repository.sendMessage(
        userMessage: 'hello again',
        history: [first],
        language: AssistantLanguage.english,
      );

      expect(first.id, isNot(second.id));
      expect(first.role, ChatMessageRole.assistant);
      expect(second.role, ChatMessageRole.assistant);
    });
  });
}
