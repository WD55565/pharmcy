# Production Deployment Guide

This document covers deploying the Nöbetçi Eczane+ backend (Spring Boot +
MySQL) and building the Flutter mobile app for production. All configuration
is environment-variable driven — nothing environment-specific is hardcoded
in source control.

## 1. Required environment variables

### Backend (`backend/`)

| Variable | Required in `prod` | Local dev default | Description |
|---|---|---|---|
| `SPRING_PROFILES_ACTIVE` | Yes (`prod`) | unset (base profile) | Activates `application-prod.properties`, which has no `localhost` fallbacks and fails fast if anything below is missing. |
| `DB_URL` | Yes | `jdbc:mysql://localhost:3306/nobetci_eczane_plus` | Full JDBC URL of the MySQL database. |
| `DB_USERNAME` | Yes | `root` | MySQL username. |
| `DB_PASSWORD` | Yes | *(empty)* | MySQL password. |
| `CORS_ALLOWED_ORIGINS` | Yes | `*` | Comma-separated list of exact origins allowed to call `/api/**` (e.g. `https://app.example.com`). No wildcard default in production — must be set explicitly. |
| `PORT` | No | `8080` | Server port. Many hosts (Railway, Render, Fly.io) inject this automatically. |

### `docker-compose` only (local production-like testing)

| Variable | Description |
|---|---|
| `DB_NAME` | Database name created inside the MySQL container (defaults to `nobetci_eczane_plus`). |
| `DB_ROOT_PASSWORD` | MySQL root password for the container. |

Copy `.env.example` to `.env` at the repo root and fill in real values before
running `docker compose up`. **Never commit `.env`.**

### Mobile (`mobile/`)

| Variable | Passed via | Description |
|---|---|---|
| `API_BASE_URL` | `--dart-define` | Backend base URL, e.g. `https://api.example.com/api`. Required for production builds — the build fails immediately (at runtime, not just in debug) if it's missing. |
| `GOOGLE_MAPS_API_KEY` | `--dart-define` (not yet wired into build config) | Reserved for future native Google Maps key wiring; unused today — see `lib/features/pharmacy/presentation/widgets/pharmacy_map_preview.dart`. |

## 2. Backend: build and run

### Plain jar

```bash
cd backend
mvn clean package
java -jar target/backend-*.jar   # reads env vars from the shell environment
```

For production:

```bash
SPRING_PROFILES_ACTIVE=prod \
DB_URL=jdbc:mysql://<host>:3306/<db> \
DB_USERNAME=<user> \
DB_PASSWORD=<password> \
CORS_ALLOWED_ORIGINS=https://app.example.com \
java -jar target/backend-*.jar
```

### Docker

```bash
cd backend
docker build -t nobetci-eczane-backend .
docker run -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=prod \
  -e DB_URL=jdbc:mysql://<host>:3306/<db> \
  -e DB_USERNAME=<user> \
  -e DB_PASSWORD=<password> \
  -e CORS_ALLOWED_ORIGINS=https://app.example.com \
  nobetci-eczane-backend
```

The image runs as a non-root user and exposes an `/actuator/health` check
(`HEALTHCHECK` is built into the Dockerfile).

### docker-compose (local production-like stack)

```bash
cp .env.example .env   # fill in real values
docker compose up --build
```

This runs MySQL and the backend together, wired entirely through
environment variables and the Docker network (the backend never talks to
`localhost` inside the container — it reaches MySQL at the `mysql` service
name).

## 3. Database and Flyway

- Flyway is enabled unconditionally (`spring.flyway.enabled=true` in both
  profiles) and runs automatically as part of the normal Spring Boot startup
  sequence — **no manual migration step is required** in any environment.
  On first boot against a fresh database it creates `flyway_schema_history`
  and applies every migration under
  `backend/src/main/resources/db/migration/` in order; on subsequent boots
  it only applies new ones.
- `spring.jpa.hibernate.ddl-auto=validate` in both profiles — Hibernate only
  verifies the schema matches the entities, it never generates or alters
  tables itself. Flyway is the single source of truth for schema changes.
- To verify migrations ran: check application startup logs for
  `Successfully applied N migration(s)`, or query
  `SELECT * FROM flyway_schema_history;` directly.

## 4. Flutter: build for production

The app has three entrypoints (see `mobile/README.md`):

- `lib/main.dart` — convenience alias to development, for local `flutter run`.
- `lib/main_development.dart` — development flavor.
- `lib/main_production.dart` — production flavor; **requires** `API_BASE_URL`.

### Release builds

```bash
cd mobile

# Android
flutter build apk --release -t lib/main_production.dart \
  --dart-define=API_BASE_URL=https://api.example.com/api

# iOS
flutter build ipa --release -t lib/main_production.dart \
  --dart-define=API_BASE_URL=https://api.example.com/api

# Web
flutter build web --release -t lib/main_production.dart \
  --dart-define=API_BASE_URL=https://api.example.com/api
```

Always pass `-t lib/main_production.dart` explicitly for release builds —
Flutter has no automatic dev/prod flavor switching here, and plain
`flutter build ...` without `-t` falls back to `lib/main.dart` (the
development entrypoint). `main_production.dart` throws a `StateError` at
startup if `API_BASE_URL` wasn't supplied, so a misconfigured release build
fails loudly instead of silently pointing nowhere.

The web build output lands in `mobile/build/web/` and can be served by any
static file host (it's a static SPA — no Node/server runtime required).

## 5. CORS

Configured in `backend/src/main/java/com/nobetcieczaneplus/config/CorsConfig.java`,
entirely driven by `app.cors.allowed-origins` (→ `CORS_ALLOWED_ORIGINS`).
Local development defaults to `*` (permissive, for the Flutter web dev
server / emulators); production has no default and must list exact origins,
comma-separated, e.g.:

```
CORS_ALLOWED_ORIGINS=https://app.nobetcieczaneplus.com
```

## 6. Health check

`GET /actuator/health` returns `{"status":"UP"}` once the app and its
database connection are healthy. Used by the Docker `HEALTHCHECK` and
suitable for a load balancer / orchestrator readiness probe.

## 7. Remaining manual steps

These are outside what a repository can configure for you:

- **Provision a real MySQL instance** (managed service or self-hosted) and
  set `DB_URL`/`DB_USERNAME`/`DB_PASSWORD` accordingly.
- **Choose and configure hosting** for the backend container (Railway,
  Fly.io, a VM, etc.) and point it at a container registry if not building
  in-place.
- **TLS/HTTPS termination** — typically handled by the hosting platform or a
  reverse proxy in front of the backend; not configured in this repo.
- **DNS** for the API domain and (if applicable) a web-hosted build of the
  Flutter app.
- **Google Maps API key** — obtain one and wire it into
  `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`
  (placeholders already present) if in-app map rendering is needed; the
  "Open in Maps" / "Show on Map" actions work today without one.
- **App store / Play Store signing and submission** — code signing
  certificates, provisioning profiles, and store listings are not part of
  this repository.
- **CI/CD pipeline** to automate the build/test/deploy commands above.
- **Monitoring/alerting** beyond the basic `/actuator/health` endpoint.
