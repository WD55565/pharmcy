import 'package:flutter/material.dart';

import '../../../../core/localization/l10n/app_localizations.dart';

/// On-duty/not-on-duty badge, shared by the pharmacy list tile and the
/// details screen so the color/label logic lives in exactly one place.
class DutyStatusChip extends StatelessWidget {
  const DutyStatusChip({required this.isOnDuty, super.key});

  final bool isOnDuty;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final color = isOnDuty
        ? theme.colorScheme.tertiary
        : theme.colorScheme.outline;

    return Chip(
      label: Text(isOnDuty ? l10n.onDuty : l10n.notOnDuty),
      visualDensity: VisualDensity.compact,
      labelStyle: theme.textTheme.labelSmall?.copyWith(color: color),
      backgroundColor: color.withValues(alpha: 0.12),
      side: BorderSide.none,
    );
  }
}
