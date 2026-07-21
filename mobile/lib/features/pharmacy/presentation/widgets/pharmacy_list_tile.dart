import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/pharmacy.dart';
import 'duty_status_chip.dart';

/// A single pharmacy row: name, district/address, phone, duty status, a tap
/// target that opens the details screen, and a prepared "open in maps"
/// action.
class PharmacyListTile extends StatelessWidget {
  const PharmacyListTile({
    required this.pharmacy,
    required this.onOpenMaps,
    this.onTap,
    super.key,
  });

  final Pharmacy pharmacy;
  final VoidCallback onOpenMaps;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final colorScheme = theme.colorScheme;

    final statusColor = pharmacy.isOnDuty
        ? colorScheme.tertiary
        : colorScheme.outline;

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // A thin accent stripe gives an at-a-glance duty signal even
              // before reading the chip text — a common premium-list
              // pattern (status colour as a border, not just a label).
              Container(width: 4, color: statusColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: statusColor.withValues(alpha: 0.15),
                        foregroundColor: statusColor,
                        child: const Icon(Icons.local_pharmacy_outlined),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pharmacy.name,
                              style: theme.textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              '${pharmacy.district} · ${pharmacy.address}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(pharmacy.phone, style: theme.textTheme.bodySmall),
                            const SizedBox(height: AppSpacing.sm),
                            DutyStatusChip(isOnDuty: pharmacy.isOnDuty),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton.filledTonal(
                        tooltip: l10n.openInMaps,
                        icon: const Icon(Icons.map_outlined),
                        onPressed: onOpenMaps,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
