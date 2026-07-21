import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/localization/l10n/app_localizations.dart';
import '../core/theme/app_theme.dart';
import '../features/assistant/presentation/widgets/assistant_launcher.dart';
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
      // Layers the assistant's floating button/panel on top of whichever
      // page GoRouter is currently showing, so it's visible everywhere
      // without every screen needing to add it itself. `builder`'s content
      // sits outside the Router's own Overlay, so Tooltip-using widgets
      // (the FAB) need their own local Overlay ancestor here.
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) => Stack(children: [?child, const AssistantLauncher()])),
          ],
        );
      },
    );
  }
}
