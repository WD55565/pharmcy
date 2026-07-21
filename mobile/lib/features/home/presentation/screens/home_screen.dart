import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_paths.dart';
import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/network/failure.dart';
import '../../../../core/network/failure_localizations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/max_width_content.dart';
import '../../../pharmacy/domain/entities/pharmacy.dart';
import '../../../pharmacy/presentation/providers/filtered_pharmacies_provider.dart';
import '../../../pharmacy/presentation/providers/pharmacy_filters_provider.dart';
import '../../../pharmacy/presentation/providers/pharmacy_list_provider.dart';
import '../../../pharmacy/presentation/widgets/district_filter_bar.dart';
import '../../../pharmacy/presentation/widgets/pharmacy_list_tile.dart';
import '../../../pharmacy/presentation/widgets/pharmacy_list_tile_skeleton.dart';

/// Home screen: search + district filter over the on-duty pharmacy list,
/// with pull-to-refresh and loading/error/empty states.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final districts = ref.watch(availableDistrictsProvider);
    final selectedDistrict = ref.watch(selectedDistrictProvider);
    final onDutyOnly = ref.watch(onDutyOnlyProvider);
    final hasActiveFilters = ref.watch(hasActiveFiltersProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeTitle)),
      body: MaxWidthContent(
        maxWidth: 1000,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.sm,
              ),
              child: _DebouncedSearchField(),
            ),
            if (districts.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: DistrictFilterBar(
                  districts: districts,
                  selectedDistrict: selectedDistrict,
                  onSelected: (district) =>
                      ref.read(selectedDistrictProvider.notifier).update(district),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                0,
              ),
              child: Row(
                children: [
                  FilterChip(
                    label: Text(l10n.onDutyOnly),
                    selected: onDutyOnly,
                    onSelected: (_) => ref.read(onDutyOnlyProvider.notifier).toggle(),
                  ),
                  const Spacer(),
                  if (hasActiveFilters)
                    TextButton.icon(
                      icon: const Icon(Icons.filter_alt_off_outlined),
                      label: Text(l10n.clearFilters),
                      onPressed: () => clearPharmacyFilters(ref),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref.read(pharmacyListProvider.notifier).refresh(),
                child: const _PharmacyResultsView(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Search field with a short debounce before updating
/// [pharmacySearchQueryProvider], so fast typing doesn't re-run the filter
/// on every keystroke — only once typing pauses.
class _DebouncedSearchField extends ConsumerStatefulWidget {
  const _DebouncedSearchField();

  @override
  ConsumerState<_DebouncedSearchField> createState() => _DebouncedSearchFieldState();
}

class _DebouncedSearchFieldState extends ConsumerState<_DebouncedSearchField> {
  static const _debounceDuration = Duration(milliseconds: 300);
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(_debounceDuration, () {
      ref.read(pharmacySearchQueryProvider.notifier).update(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SearchBar(
      hintText: l10n.searchHint,
      leading: const Icon(Icons.search),
      elevation: const WidgetStatePropertyAll(0),
      onChanged: _onChanged,
    );
  }
}

/// Watches [filteredPharmaciesProvider] itself (rather than receiving the
/// value from [HomeScreen]) so that typing in the search field or toggling
/// a filter only rebuilds this subtree — not the app bar, search field, or
/// filter chips above it.
class _PharmacyResultsView extends ConsumerWidget {
  const _PharmacyResultsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final pharmacies = ref.watch(filteredPharmaciesProvider);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: pharmacies.when(
        loading: () => const _PharmacySkeletonList(key: ValueKey('loading')),
        error: (error, stackTrace) => _scrollableCenter(
          key: const ValueKey('error'),
          child: ErrorView(
            message: error is Failure
                ? localizedFailureMessage(l10n, error)
                : l10n.errorUnknown,
            onRetry: () => ref.invalidate(pharmacyListProvider),
          ),
        ),
        data: (data) {
          if (data.isEmpty) {
            final hasActiveFilters = ref.watch(hasActiveFiltersProvider);
            return _scrollableCenter(
              key: const ValueKey('empty'),
              child: EmptyView(
                icon: Icons.local_pharmacy_outlined,
                message: '${l10n.noPharmaciesFound}\n${l10n.noPharmaciesFoundHint}',
                action: hasActiveFilters
                    ? OutlinedButton.icon(
                        icon: const Icon(Icons.filter_alt_off_outlined),
                        label: Text(l10n.clearFilters),
                        onPressed: () => clearPharmacyFilters(ref),
                      )
                    : null,
              ),
            );
          }

          return ResponsiveLayout(
            key: const ValueKey('data'),
            mobile: (context) => _PharmacyListView(pharmacies: data),
            tablet: (context) => _PharmacyGridView(pharmacies: data),
          );
        },
      ),
    );
  }

  Widget _scrollableCenter({required Widget child, required Key key}) {
    return LayoutBuilder(
      key: key,
      builder: (context, constraints) => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [SizedBox(height: constraints.maxHeight, child: child)],
      ),
    );
  }
}

/// Fixed-size list of skeleton tiles shown while the pharmacy list loads —
/// previews the eventual layout instead of a bare spinner.
class _PharmacySkeletonList extends StatelessWidget {
  const _PharmacySkeletonList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: 6,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => const PharmacyListTileSkeleton(),
    );
  }
}

class _PharmacyListView extends StatelessWidget {
  const _PharmacyListView({required this.pharmacies});

  final List<Pharmacy> pharmacies;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // Tiles are stateless data displays — no need to keep their element
      // subtree alive once scrolled off-screen, which matters once the
      // list is long (e.g. an unfiltered city-wide pharmacy list).
      addAutomaticKeepAlives: false,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: pharmacies.length,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final pharmacy = pharmacies[index];
        return FadeSlideIn(
          delay: Duration(milliseconds: (index * 30).clamp(0, 300)),
          child: PharmacyListTile(
            // Keyed by stable id (not index) so Flutter correctly matches
            // tiles across filter/search changes instead of reusing an
            // element for what is now a different pharmacy.
            key: ValueKey(pharmacy.id),
            pharmacy: pharmacy,
            onOpenMaps: () => _showMapsComingSoon(context),
            onTap: () => context.pushNamed(
              RouteNames.pharmacyDetail,
              pathParameters: {'id': pharmacy.id.toString()},
            ),
          ),
        );
      },
    );
  }
}

class _PharmacyGridView extends StatelessWidget {
  const _PharmacyGridView({required this.pharmacies});

  final List<Pharmacy> pharmacies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      addAutomaticKeepAlives: false,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.lg),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 480,
        mainAxisExtent: 190,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
      ),
      itemCount: pharmacies.length,
      itemBuilder: (context, index) {
        final pharmacy = pharmacies[index];
        return FadeSlideIn(
          delay: Duration(milliseconds: (index * 30).clamp(0, 300)),
          child: PharmacyListTile(
            key: ValueKey(pharmacy.id),
            pharmacy: pharmacy,
            onOpenMaps: () => _showMapsComingSoon(context),
            onTap: () => context.pushNamed(
              RouteNames.pharmacyDetail,
              pathParameters: {'id': pharmacy.id.toString()},
            ),
          ),
        );
      },
    );
  }
}

void _showMapsComingSoon(BuildContext context) {
  final l10n = AppLocalizations.of(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.mapsComingSoon)));
}
