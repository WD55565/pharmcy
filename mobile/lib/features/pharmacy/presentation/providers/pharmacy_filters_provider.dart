import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pharmacy_filters_provider.g.dart';

/// Current search-by-name query, updated as the user types.
@riverpod
class PharmacySearchQuery extends _$PharmacySearchQuery {
  @override
  String build() => '';

  void update(String value) => state = value;
}

/// Currently selected district filter; `null` means "all districts".
@riverpod
class SelectedDistrict extends _$SelectedDistrict {
  @override
  String? build() => null;

  void update(String? value) => state = value;
}

/// Whether the list should be narrowed to on-duty pharmacies only.
@riverpod
class OnDutyOnly extends _$OnDutyOnly {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

/// True when any of search/district/on-duty filters are currently active,
/// used to show/hide the "Clear Filters" action.
@riverpod
bool hasActiveFilters(Ref ref) {
  final hasQuery = ref.watch(pharmacySearchQueryProvider).trim().isNotEmpty;
  final hasDistrict = ref.watch(selectedDistrictProvider) != null;
  final onDutyOnly = ref.watch(onDutyOnlyProvider);
  return hasQuery || hasDistrict || onDutyOnly;
}

/// Resets search query, district, and on-duty filters back to their
/// defaults in one call.
void clearPharmacyFilters(WidgetRef ref) {
  ref.read(pharmacySearchQueryProvider.notifier).update('');
  ref.read(selectedDistrictProvider.notifier).update(null);
  if (ref.read(onDutyOnlyProvider)) {
    ref.read(onDutyOnlyProvider.notifier).toggle();
  }
}
