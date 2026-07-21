import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';
import 'features/pharmacy/data/datasources/pharmacy_favorites_local_data_source.dart';

/// Shared startup path for every entrypoint (`main_development.dart`,
/// `main_production.dart`). Each entrypoint only needs to build an
/// [AppConfig] and hand it here.
Future<void> bootstrap(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        pharmacyFavoritesLocalDataSourceProvider.overrideWithValue(
          PharmacyFavoritesLocalDataSource(prefs),
        ),
      ],
      child: const NobetciEczaneApp(),
    ),
  );
}
