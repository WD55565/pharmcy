import '../localization/l10n/app_localizations.dart';
import 'failure.dart';

/// Maps a [Failure] to a localized, user-friendly message. Use this at
/// every UI call site that shows an error to the user — [Failure]'s own
/// `diagnosticMessage` is English-only and may echo raw backend text,
/// which isn't appropriate to show directly.
String localizedFailureMessage(AppLocalizations l10n, Failure failure) {
  return switch (failure) {
    NetworkFailure() => l10n.errorNetwork,
    TimeoutFailure() => l10n.errorTimeout,
    ServerFailure() => l10n.errorServer,
    UnknownFailure() => l10n.errorUnknown,
  };
}
