import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/result.dart';
import '../../data/repositories/pharmacy_repository_impl.dart';
import '../../domain/entities/pharmacy.dart';

part 'pharmacy_list_provider.g.dart';

/// Fetches the full pharmacy list from the backend. Search and district
/// filtering are applied on top of this by [filteredPharmaciesProvider]
/// rather than re-fetching, since the backend only exposes `GET /pharmacies`
/// (no query parameters).
@riverpod
class PharmacyList extends _$PharmacyList {
  @override
  Future<List<Pharmacy>> build() async {
    final repository = ref.watch(pharmacyRepositoryProvider);
    final result = await repository.getPharmacies();
    return switch (result) {
      ResultSuccess(:final data) => data,
      ResultFailure(:final failure) => throw failure,
    };
  }

  /// Used by pull-to-refresh: re-fetches and waits for the new data (or
  /// error) so the caller can await the [RefreshIndicator] completing. Any
  /// failure ends up in [state] as an [AsyncError], not rethrown here.
  Future<void> refresh() async {
    ref.invalidateSelf();
    try {
      await future;
    } catch (_) {
      // Already reflected in `state`; nothing further to do.
    }
  }
}
