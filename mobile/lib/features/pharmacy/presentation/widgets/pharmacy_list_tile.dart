import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: statusColor.withValues(alpha: 0.15),
                foregroundColor: statusColor,
                child: const Icon(Icons.local_pharmacy_outlined),
              ),
              const SizedBox(width: 12),
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
                    const SizedBox(height: 4),
                    Text(
                      '${pharmacy.district} · ${pharmacy.address}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(pharmacy.phone, style: theme.textTheme.bodySmall),
                    const SizedBox(height: 8),
                    DutyStatusChip(isOnDuty: pharmacy.isOnDuty),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                tooltip: l10n.openInMaps,
                icon: const Icon(Icons.map_outlined),
                onPressed: onOpenMaps,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
