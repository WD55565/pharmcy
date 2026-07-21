import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/localization/l10n/app_localizations.dart';
import '../core/theme/app_theme.dart';
import 'router/app_router.dart';

/// Root widget. Wires theme, localization, and routing together; feature
/// screens never touch [MaterialApp] configuration directly.
class NobetciEczaneApp extends ConsumerWidget {
  const NobetciEczaneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // The assistant FAB/panel is layered on every page via a ShellRoute
      // in app_router.dart (not here) so it stays a genuine descendant of
      // GoRouter's own Navigator/Overlay.
    );
  }
}
