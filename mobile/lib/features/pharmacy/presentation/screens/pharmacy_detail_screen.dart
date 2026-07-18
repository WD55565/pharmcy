import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/network/failure.dart';
import '../../../../core/network/failure_localizations.dart';
import '../../../../core/utils/external_actions.dart';
import '../../../../core/utils/time_format.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../domain/entities/pharmacy.dart';
import '../providers/pharmacy_detail_provider.dart';
import '../providers/pharmacy_favorites_provider.dart';
import '../widgets/duty_status_chip.dart';
import '../widgets/pharmacy_map_preview.dart';

/// Details for a single pharmacy: full info, call/maps/share actions, and a
/// (UI-only, not yet persisted) favorite toggle.
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
      body: pharmacyAsync.when(
        loading: () => const LoadingView(),
        error: (error, stackTrace) => ErrorView(
          message: _describeError(l10n, error),
          onRetry: () => ref.invalidate(pharmacyDetailProvider(pharmacyId)),
        ),
        data: (pharmacy) => _PharmacyDetailBody(pharmacy: pharmacy),
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
      pharmacyFavoritesProvider.select(
        (favorites) => favorites.contains(pharmacyId),
      ),
    );

    return IconButton(
      tooltip: isFavorite ? l10n.removeFromFavorites : l10n.addToFavorites,
      icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () =>
          ref.read(pharmacyFavoritesProvider.notifier).toggle(pharmacyId),
    );
  }
}

/// A 404 specifically means "this pharmacy id doesn't exist" — worth a more
/// precise message than the generic server-error copy.
String _describeError(AppLocalizations l10n, Object error) {
  if (error is ServerFailure && error.statusCode == 404) {
    return l10n.pharmacyNotFound;
  }
  return error is Failure
      ? localizedFailureMessage(l10n, error)
      : l10n.errorUnknown;
}

class _PharmacyDetailBody extends StatelessWidget {
  const _PharmacyDetailBody({required this.pharmacy});

  final Pharmacy pharmacy;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final openingTime = formatDutyTime(pharmacy.openingTime);
    final closingTime = formatDutyTime(pharmacy.closingTime);
    final hasDutyHours = openingTime != null || closingTime != null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  pharmacy.name,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              const SizedBox(width: 12),
              DutyStatusChip(isOnDuty: pharmacy.isOnDuty),
            ],
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(
                    icon: Icons.location_on_outlined,
                    label: l10n.addressLabel,
                    value: pharmacy.address,
                  ),
                  const Divider(height: 24),
                  _DetailRow(
                    icon: Icons.map_outlined,
                    label: l10n.districtLabel,
                    value: pharmacy.district,
                  ),
                  const Divider(height: 24),
                  _DetailRow(
                    icon: Icons.phone_outlined,
                    label: l10n.phoneLabel,
                    value: pharmacy.phone,
                  ),
                  const Divider(height: 24),
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
            const SizedBox(height: 16),
            PharmacyMapPreview(
              pharmacy: pharmacy,
              onTap: () => _handleOpenMaps(context, pharmacy),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  icon: const Icon(Icons.call_outlined),
                  label: Text(l10n.callAction),
                  onPressed: () => _handleCall(context, pharmacy),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.map_outlined),
                  label: Text(l10n.openInMaps),
                  onPressed: () => _handleOpenMaps(context, pharmacy),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.actionUnavailable)));
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

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
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 2),
              Text(value, style: theme.textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
