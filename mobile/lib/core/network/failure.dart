import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

/// Domain-level representation of "something went wrong" for network calls.
/// UI code (error states) and domain code depend only on this, never on
/// [DioException] directly.
@freezed
sealed class Failure with _$Failure {
  const factory Failure.network(String message) = NetworkFailure;

  const factory Failure.timeout(String message) = TimeoutFailure;

  const factory Failure.server(String message, {int? statusCode}) =
      ServerFailure;

  const factory Failure.unknown(String message) = UnknownFailure;
}

extension FailureMessage on Failure {
  /// The raw, English-only diagnostic message captured when this failure
  /// was created (e.g. for logging). **Not localized** — do not show this
  /// directly to end users. Screens should use
  /// `localizedFailureMessage(l10n, failure)` (see `failure_localizations.dart`)
  /// for any user-facing text instead.
  String get diagnosticMessage => switch (this) {
    NetworkFailure(:final message) => message,
    TimeoutFailure(:final message) => message,
    ServerFailure(:final message) => message,
    UnknownFailure(:final message) => message,
  };
}
