// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nöbetçi Eczane+';

  @override
  String get homeTitle => 'Home';

  @override
  String get loading => 'Loading...';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorRetry => 'Retry';

  @override
  String get emptyTitle => 'No results found';

  @override
  String get searchHint => 'Search by name, district, or address';

  @override
  String get districtAll => 'All Districts';

  @override
  String get onDuty => 'On Duty';

  @override
  String get notOnDuty => 'Not On Duty';

  @override
  String get openInMaps => 'Show on Map';

  @override
  String get mapsComingSoon => 'Maps integration coming soon';

  @override
  String get noPharmaciesFound => 'No pharmacies found';

  @override
  String get noPharmaciesFoundHint =>
      'Try adjusting your search or district filter.';

  @override
  String get addressLabel => 'Address';

  @override
  String get districtLabel => 'District';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get dutyHoursLabel => 'Duty Hours';

  @override
  String get dutyHoursNotSpecified => 'Not specified';

  @override
  String get callAction => 'Call';

  @override
  String get shareAction => 'Share';

  @override
  String get addToFavorites => 'Add to Favorites';

  @override
  String get removeFromFavorites => 'Remove from Favorites';

  @override
  String get actionUnavailable => 'This action isn\'t available right now';

  @override
  String get pharmacyNotFound => 'Pharmacy not found';

  @override
  String get onDutyOnly => 'On Duty Only';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get errorNetwork =>
      'No internet connection. Please check your network and try again.';

  @override
  String get errorTimeout => 'The request timed out. Please try again.';

  @override
  String get errorServer =>
      'Something went wrong on our end. Please try again shortly.';

  @override
  String get errorUnknown => 'An unexpected error occurred. Please try again.';
}
