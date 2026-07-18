import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/pharmacy/data/models/pharmacy_model.dart';

void main() {
  group('PharmacyModel.fromJson', () {
    test('parses the exact shape returned by the Spring Boot backend', () {
      // Captured verbatim from a live `GET /api/pharmacies` response against
      // the backend in `backend/`, to catch any drift between the mobile
      // model and PharmacyResponse.java without needing a live server here.
      const json = {
        'id': 1,
        'name': 'Test Eczanesi',
        'phone': '0212 000 00 00',
        'address': 'Test Sokak No:1',
        'district': 'Kadıköy',
        'latitude': 40.99,
        'longitude': 29.03,
        'isOnDuty': true,
      };

      final model = PharmacyModel.fromJson(json);

      expect(model.id, 1);
      expect(model.name, 'Test Eczanesi');
      expect(model.phone, '0212 000 00 00');
      expect(model.address, 'Test Sokak No:1');
      expect(model.district, 'Kadıköy');
      expect(model.latitude, 40.99);
      expect(model.longitude, 29.03);
      expect(model.isOnDuty, true);
    });

    test('toEntity maps every field onto the domain entity', () {
      const model = PharmacyModel(
        id: 1,
        name: 'Test Eczanesi',
        phone: '0212 000 00 00',
        address: 'Test Sokak No:1',
        district: 'Kadıköy',
        latitude: 40.99,
        longitude: 29.03,
        isOnDuty: true,
      );

      final entity = model.toEntity();

      expect(entity.id, model.id);
      expect(entity.name, model.name);
      expect(entity.phone, model.phone);
      expect(entity.address, model.address);
      expect(entity.district, model.district);
      expect(entity.latitude, model.latitude);
      expect(entity.longitude, model.longitude);
      expect(entity.isOnDuty, model.isOnDuty);
    });

    test('parses opening/closing time strings as returned by the backend', () {
      // Captured verbatim from a live `GET /api/pharmacies/{id}` response
      // after setting opening_time/closing_time directly in MySQL — confirms
      // java.time.LocalTime serializes as "HH:mm:ss" and this model accepts
      // it as-is.
      const json = {
        'id': 2,
        'name': 'Saat Testi Eczanesi',
        'phone': '0212 111 11 11',
        'address': 'Test Cad. No:5',
        'district': 'Beşiktaş',
        'latitude': 41.04,
        'longitude': 29.0,
        'isOnDuty': false,
        'openingTime': '09:00:00',
        'closingTime': '19:30:00',
      };

      final model = PharmacyModel.fromJson(json);

      expect(model.openingTime, '09:00:00');
      expect(model.closingTime, '19:30:00');
      expect(model.toEntity().openingTime, '09:00:00');
      expect(model.toEntity().closingTime, '19:30:00');
    });

    test(
      'treats missing opening/closing time as null rather than throwing',
      () {
        const json = {
          'id': 1,
          'name': 'Test Eczanesi',
          'phone': '0212 000 00 00',
          'address': 'Test Sokak No:1',
          'district': 'Kadıköy',
          'latitude': 40.99,
          'longitude': 29.03,
          'isOnDuty': true,
          'openingTime': null,
          'closingTime': null,
        };

        final model = PharmacyModel.fromJson(json);

        expect(model.openingTime, isNull);
        expect(model.closingTime, isNull);
      },
    );
  });
}
