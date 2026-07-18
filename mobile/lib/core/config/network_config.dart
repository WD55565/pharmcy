/// Centralized network tuning values, so timeouts aren't repeated as magic
/// numbers at every call site that configures a [Dio] instance.
abstract final class NetworkConfig {
  static const Duration requestTimeout = Duration(seconds: 10);
}
