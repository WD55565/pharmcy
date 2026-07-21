import 'package:flutter/material.dart';

import '../localization/l10n/app_localizations.dart';
import '../theme/app_spacing.dart';

/// Standard full-area empty state, shown when a request succeeds but
/// returns no data (e.g. no on-duty pharmacies for a filter).
class EmptyView extends StatelessWidget {
  const EmptyView({
    this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
    super.key,
  });

  final String? message;
  final IconData icon;

  /// Optional action shown below the message, e.g. a "Clear Filters" button
  /// when the empty result is caused by active filters rather than a truly
  /// empty dataset.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHigh,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: colorScheme.outline),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message ?? l10n.emptyTitle,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[const SizedBox(height: AppSpacing.lg), action!],
          ],
        ),
      ),
    );
  }
}
