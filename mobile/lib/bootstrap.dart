import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';

/// Shared startup path for every entrypoint (`main_development.dart`,
/// `main_production.dart`). Each entrypoint only needs to build an
/// [AppConfig] and hand it here.
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      overrides: [appConfigProvider.overrideWithValue(config)],
      child: const NobetciEczaneApp(),
    ),
  );
}
