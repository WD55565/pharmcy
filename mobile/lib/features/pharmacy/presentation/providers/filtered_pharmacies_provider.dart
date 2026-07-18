import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/turkish_text.dart';
import '../../domain/entities/pharmacy.dart';
import 'pharmacy_filters_provider.dart';
import 'pharmacy_list_provider.dart';

part 'filtered_pharmacies_provider.g.dart';

/// [pharmacyListProvider]'s data, narrowed by the current search query,
/// district selection, and on-duty toggle. All filtering happens in memory
/// on the already-fetched list — no additional HTTP requests are made while
/// the user types or changes filters. Loading/error states pass through
/// unchanged so the screen only needs to handle one [AsyncValue].
@riverpod
AsyncValue<List<Pharmacy>> filteredPharmacies(Ref ref) {
  final pharmaciesAsync = ref.watch(pharmacyListProvider);
  final query = normalizeTurkish(ref.watch(pharmacySearchQueryProvider).trim());
  final district = ref.watch(selectedDistrictProvider);
  final onDutyOnly = ref.watch(onDutyOnlyProvider);

  return pharmaciesAsync.whenData((pharmacies) {
    return pharmacies.where((pharmacy) {
      final matchesQuery = query.isEmpty || _matchesSearch(pharmacy, query);
      final matchesDistrict = district == null || pharmacy.district == district;
      final matchesDuty = !onDutyOnly || pharmacy.isOnDuty;
      return matchesQuery && matchesDistrict && matchesDuty;
    }).toList();
  });
}

/// Matches [query] (already normalized) against pharmacy name, district,
/// and address — case-insensitively and Turkish-character-aware.
bool _matchesSearch(Pharmacy pharmacy, String query) {
  return normalizeTurkish(pharmacy.name).contains(query) ||
      normalizeTurkish(pharmacy.district).contains(query) ||
      normalizeTurkish(pharmacy.address).contains(query);
}

/// Distinct, sorted district names from the full (unfiltered) list, used to
/// populate the district filter chips.
@riverpod
List<String> availableDistricts(Ref ref) {
  final pharmacies = ref.watch(pharmacyListProvider).value ?? const [];
  final districts = pharmacies
      .map((pharmacy) => pharmacy.district)
      .toSet()
      .toList();
  districts.sort();
  return districts;
}
