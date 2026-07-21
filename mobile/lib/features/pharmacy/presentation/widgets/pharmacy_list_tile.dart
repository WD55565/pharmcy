import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/entities/pharmacy.dart';
import 'duty_status_chip.dart';

/// A single pharmacy row: name, district/address, phone, duty status, a tap
/// target that opens the details screen, and a prepared "open in maps"
/// action. Lifts slightly with a soft shadow on hover/press, matching the
/// app's general card-motion language.
class PharmacyListTile extends StatefulWidget {
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
  State<PharmacyListTile> createState() => _PharmacyListTileState();
}

class _PharmacyListTileState extends State<PharmacyListTile> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final colorScheme = theme.colorScheme;
    final pharmacy = widget.pharmacy;

    final statusColor = pharmacy.isOnDuty
        ? colorScheme.tertiary
        : colorScheme.outline;

    final lifted = _hovered && !_pressed;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, lifted ? -3 : 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: lifted
                ? [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.18),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : const [],
          ),
          child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onTap,
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
                              backgroundColor: statusColor.withValues(
                                alpha: 0.15,
                              ),
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
                                  Text(
                                    pharmacy.phone,
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  DutyStatusChip(isOnDuty: pharmacy.isOnDuty),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            IconButton.filledTonal(
                              tooltip: l10n.openInMaps,
                              icon: const Icon(Icons.map_outlined),
                              onPressed: widget.onOpenMaps,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
