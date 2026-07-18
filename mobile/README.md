# Nöbetçi Eczane+ — Mobile

Flutter client for the Nöbetçi Eczane+ project. This is the architectural
foundation only — no pharmacy features are implemented yet (see
`lib/features/pharmacy/*/README.md` for the intended layering).

## Stack

- **State management:** Riverpod (`flutter_riverpod` + `riverpod_generator`)
- **Navigation:** GoRouter
- **Networking:** Dio
- **Code generation:** Freezed + json_serializable
- **Localization:** Turkish (default) and English, via `flutter gen-l10n`

## Folder structure

```
lib/
  app/            Root widget, GoRouter configuration
  core/           Cross-feature infrastructure: config, network, theme,
                  localization, reusable widgets, responsive helpers, maps
  features/
    home/         App shell placeholder screen
    pharmacy/     Clean-architecture skeleton (data/domain/presentation) —
                  documented, not yet implemented
  bootstrap.dart  Shared startup path for all entrypoints
  main.dart               Convenience alias to the development entrypoint
  main_development.dart   Development flavor entrypoint
  main_production.dart    Production flavor entrypoint
```

Each feature follows `data -> domain -> presentation`: data sources and
models are wrapped by repositories implementing a domain-level interface,
consumed by use cases, exposed to the UI via Riverpod providers.

## Running

```
# Development (defaults to the Android emulator's host-loopback address)
flutter run -t lib/main_development.dart \
  --dart-define=API_BASE_URL=http://10.0.2.2:8080/api

# Production (API_BASE_URL is required; there is no default)
flutter build apk -t lib/main_production.dart \
  --dart-define=API_BASE_URL=https://<production-host>/api
```

Plain `flutter run` (no `-t`) uses `lib/main.dart`, which delegates to the
development entrypoint with its default local backend URL.

## Backend integration

Points at the existing Spring Boot backend (`backend/`). `core/network/dio_client.dart`
builds a single `Dio` instance from `AppConfig.apiBaseUrl`; endpoint paths are
centralized in `core/config/api_endpoints.dart` rather than being inlined
per request.

## Google Maps

`google_maps_flutter` is added as a dependency and the Android/iOS
placeholders for an API key are in place (see comments in
`android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`),
but no key is configured yet — see `lib/core/maps/map_config.dart`.

## Code generation

After changing anything annotated with `@freezed` or `@riverpod`:

```
dart run build_runner build --delete-conflicting-outputs
```

After changing an `.arb` file under `lib/core/localization/l10n/`:

```
flutter gen-l10n
```
