import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/result.dart';
import '../../data/repositories/pharmacy_repository_impl.dart';
import '../../domain/entities/pharmacy.dart';

part 'pharmacy_detail_provider.g.dart';

/// Fetches a single pharmacy by id for the details screen. Keyed by [id] so
/// each pharmacy detail has its own independent cached/async state.
@riverpod
class PharmacyDetail extends _$PharmacyDetail {
  @override
  Future<Pharmacy> build(int id) async {
    final repository = ref.watch(pharmacyRepositoryProvider);
    final result = await repository.getPharmacyById(id);
    return switch (result) {
      ResultSuccess(:final data) => data,
      ResultFailure(:final failure) => throw failure,
    };
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
    try {
      await future;
    } catch (_) {
      // Already reflected in `state`; nothing further to do.
    }
  }
}
