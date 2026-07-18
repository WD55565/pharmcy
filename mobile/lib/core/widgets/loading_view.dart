import 'package:flutter/material.dart';

import '../localization/l10n/app_localizations.dart';

/// Standard full-area loading state. Use wherever a screen or section is
/// waiting on async data instead of ad-hoc [CircularProgressIndicator]s.
class LoadingView extends StatelessWidget {
  const LoadingView({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            message ?? l10n.loading,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
