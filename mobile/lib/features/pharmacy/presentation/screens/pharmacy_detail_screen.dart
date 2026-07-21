import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/network/failure.dart';
import '../../../../core/network/failure_localizations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/external_actions.dart';
import '../../../../core/utils/time_format.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/fade_slide_in.dart';
import '../../../../core/widgets/max_width_content.dart';
import '../../domain/entities/pharmacy.dart';
import '../providers/pharmacy_detail_provider.dart';
import '../providers/pharmacy_favorites_provider.dart';
import '../widgets/duty_status_chip.dart';
import '../widgets/pharmacy_detail_skeleton.dart';
import '../widgets/pharmacy_map_preview.dart';

/// Details for a single pharmacy: full info, call/maps/share actions, and a
/// favorite toggle persisted on-device.
class PharmacyDetailScreen extends ConsumerWidget {
  const PharmacyDetailScreen({required this.pharmacyId, super.key});

  final int pharmacyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final pharmacyAsync = ref.watch(pharmacyDetailProvider(pharmacyId));

    return Scaffold(
      appBar: AppBar(
        title: Text(pharmacyAsync.value?.name ?? l10n.loading),
        actions: [_FavoriteToggleButton(pharmacyId: pharmacyId)],
      ),
      body: MaxWidthContent(
        maxWidth: 720,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: pharmacyAsync.when(
            loading: () => const PharmacyDetailSkeleton(key: ValueKey('loading')),
            error: (error, stackTrace) => ErrorView(
              key: const ValueKey('error'),
              message: _describeError(l10n, error),
              onRetry: () => ref.invalidate(pharmacyDetailProvider(pharmacyId)),
            ),
            data: (pharmacy) => _PharmacyDetailBody(
              key: const ValueKey('data'),
              pharmacy: pharmacy,
            ),
          ),
        ),
      ),
    );
  }
}

/// Isolated so toggling the favorite doesn't rebuild the rest of the
/// screen — in particular the map preview, which embeds a native platform
/// view and is comparatively expensive to rebuild.
class _FavoriteToggleButton extends ConsumerWidget {
  const _FavoriteToggleButton({required this.pharmacyId});

  final int pharmacyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isFavorite = ref.watch(
      pharmacyFavoritesProvider.select((favorites) => favorites.contains(pharmacyId)),
    );

    return IconButton(
      tooltip: isFavorite ? l10n.removeFromFavorites : l10n.addToFavorites,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(isFavorite),
        ),
      ),
      onPressed: () => ref.read(pharmacyFavoritesProvider.notifier).toggle(pharmacyId),
    );
  }
}

/// A 404 specifically means "this pharmacy id doesn't exist" — worth a more
/// precise message than the generic server-error copy.
String _describeError(AppLocalizations l10n, Object error) {
  if (error is ServerFailure && error.statusCode == 404) {
    return l10n.pharmacyNotFound;
  }
  return error is Failure ? localizedFailureMessage(l10n, error) : l10n.errorUnknown;
}

class _PharmacyDetailBody extends StatelessWidget {
  const _PharmacyDetailBody({required this.pharmacy, super.key});

  final Pharmacy pharmacy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final openingTime = formatDutyTime(pharmacy.openingTime);
    final closingTime = formatDutyTime(pharmacy.closingTime);
    final hasDutyHours = openingTime != null || closingTime != null;

    return FadeSlideIn(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(pharmacy.name, style: theme.textTheme.headlineSmall),
                ),
                const SizedBox(width: AppSpacing.md),
                DutyStatusChip(isOnDuty: pharmacy.isOnDuty),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailRow(
                      icon: Icons.location_on_outlined,
                      label: l10n.addressLabel,
                      value: pharmacy.address,
                    ),
                    const Divider(height: AppSpacing.xl),
                    _DetailRow(
                      icon: Icons.map_outlined,
                      label: l10n.districtLabel,
                      value: pharmacy.district,
                    ),
                    const Divider(height: AppSpacing.xl),
                    _DetailRow(
                      icon: Icons.phone_outlined,
                      label: l10n.phoneLabel,
                      value: pharmacy.phone,
                    ),
                    const Divider(height: AppSpacing.xl),
                    _DetailRow(
                      icon: Icons.schedule_outlined,
                      label: l10n.dutyHoursLabel,
                      value: hasDutyHours
                          ? '${openingTime ?? '--:--'} - ${closingTime ?? '--:--'}'
                          : l10n.dutyHoursNotSpecified,
                    ),
                  ],
                ),
              ),
            ),
            if (pharmacy.hasCoordinates) ...[
              const SizedBox(height: AppSpacing.lg),
              PharmacyMapPreview(
                pharmacy: pharmacy,
                onTap: () => _handleOpenMaps(context, pharmacy),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    icon: const Icon(Icons.call_outlined),
                    label: Text(l10n.callAction),
                    onPressed: () => _handleCall(context, pharmacy),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.map_outlined),
                    label: Text(l10n.openInMaps),
                    onPressed: () => _handleOpenMaps(context, pharmacy),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.share_outlined),
                label: Text(l10n.shareAction),
                onPressed: () => _handleShare(pharmacy),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleCall(BuildContext context, Pharmacy pharmacy) async {
    final launched = await launchPhoneCall(pharmacy.phone);
    if (!launched && context.mounted) _showActionUnavailable(context);
  }

  Future<void> _handleOpenMaps(BuildContext context, Pharmacy pharmacy) async {
    final launched = await launchMaps(
      latitude: pharmacy.hasCoordinates ? pharmacy.latitude : null,
      longitude: pharmacy.hasCoordinates ? pharmacy.longitude : null,
      fallbackQuery: '${pharmacy.address}, ${pharmacy.district}',
    );
    if (!launched && context.mounted) _showActionUnavailable(context);
  }

  Future<void> _handleShare(Pharmacy pharmacy) {
    return shareText(
      '${pharmacy.name}\n${pharmacy.address}, ${pharmacy.district}\n${pharmacy.phone}',
      subject: pharmacy.name,
    );
  }

  void _showActionUnavailable(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.actionUnavailable)));
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(value, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
