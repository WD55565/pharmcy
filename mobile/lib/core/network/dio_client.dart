import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../config/network_config.dart';

part 'dio_client.g.dart';

/// Single, app-wide [Dio] instance pointed at the Spring Boot backend
/// (`api.apiBaseUrl` comes from the active [AppConfig], never hardcoded).
/// Feature-level data sources depend on this provider rather than
/// constructing their own Dio instances.
@riverpod
Dio dio(Ref ref) {
  final config = ref.watch(appConfigProvider);

  final client = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: NetworkConfig.requestTimeout,
      receiveTimeout: NetworkConfig.requestTimeout,
      sendTimeout: NetworkConfig.requestTimeout,
      headers: const {'Content-Type': 'application/json'},
    ),
  );

  if (config.isDevelopment) {
    client.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );
  }

  return client;
}
