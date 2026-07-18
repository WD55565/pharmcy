import 'package:flutter/material.dart';

import '../localization/l10n/app_localizations.dart';

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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: Theme.of(context).colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              message ?? l10n.emptyTitle,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
