import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('tr'),
    Locale('en'),
  ];

  /// The application title shown in the OS task switcher and app bar.
  ///
  /// In tr, this message translates to:
  /// **'Nöbetçi Eczane+'**
  String get appTitle;

  /// Title of the home screen.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfa'**
  String get homeTitle;

  /// Generic loading state message.
  ///
  /// In tr, this message translates to:
  /// **'Yükleniyor...'**
  String get loading;

  /// Generic error state title.
  ///
  /// In tr, this message translates to:
  /// **'Bir şeyler ters gitti'**
  String get errorTitle;

  /// Retry button label on error states.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get errorRetry;

  /// Generic empty state title.
  ///
  /// In tr, this message translates to:
  /// **'Sonuç bulunamadı'**
  String get emptyTitle;

  /// Placeholder for the pharmacy search field.
  ///
  /// In tr, this message translates to:
  /// **'Ad, ilçe veya adrese göre ara'**
  String get searchHint;

  /// Label for the 'all districts' filter chip.
  ///
  /// In tr, this message translates to:
  /// **'Tüm İlçeler'**
  String get districtAll;

  /// Badge label for a pharmacy currently on duty.
  ///
  /// In tr, this message translates to:
  /// **'Nöbetçi'**
  String get onDuty;

  /// Badge label for a pharmacy not currently on duty.
  ///
  /// In tr, this message translates to:
  /// **'Nöbetçi Değil'**
  String get notOnDuty;

  /// Tooltip for the button that will open a pharmacy's location in maps.
  ///
  /// In tr, this message translates to:
  /// **'Haritada Göster'**
  String get openInMaps;

  /// Shown when the maps button is tapped before Maps integration is configured.
  ///
  /// In tr, this message translates to:
  /// **'Harita entegrasyonu yakında eklenecek'**
  String get mapsComingSoon;

  /// Empty state message when the pharmacy list (after filtering) has no results.
  ///
  /// In tr, this message translates to:
  /// **'Eczane bulunamadı'**
  String get noPharmaciesFound;

  /// Empty state hint suggesting the user adjust search/filter.
  ///
  /// In tr, this message translates to:
  /// **'Arama veya ilçe filtresini değiştirmeyi deneyin.'**
  String get noPharmaciesFoundHint;

  /// Label for the pharmacy address field on the details screen.
  ///
  /// In tr, this message translates to:
  /// **'Adres'**
  String get addressLabel;

  /// Label for the pharmacy district field on the details screen.
  ///
  /// In tr, this message translates to:
  /// **'İlçe'**
  String get districtLabel;

  /// Label for the pharmacy phone field on the details screen.
  ///
  /// In tr, this message translates to:
  /// **'Telefon'**
  String get phoneLabel;

  /// Label for the opening/closing duty hours section.
  ///
  /// In tr, this message translates to:
  /// **'Nöbet Saatleri'**
  String get dutyHoursLabel;

  /// Shown when opening/closing time is not available for a pharmacy.
  ///
  /// In tr, this message translates to:
  /// **'Belirtilmemiş'**
  String get dutyHoursNotSpecified;

  /// Button label to call the pharmacy.
  ///
  /// In tr, this message translates to:
  /// **'Ara'**
  String get callAction;

  /// Button label to share the pharmacy.
  ///
  /// In tr, this message translates to:
  /// **'Paylaş'**
  String get shareAction;

  /// Tooltip/action to add a pharmacy to favorites.
  ///
  /// In tr, this message translates to:
  /// **'Favorilere Ekle'**
  String get addToFavorites;

  /// Tooltip/action to remove a pharmacy from favorites.
  ///
  /// In tr, this message translates to:
  /// **'Favorilerden Çıkar'**
  String get removeFromFavorites;

  /// Shown when an external action (call, maps, share) could not be launched.
  ///
  /// In tr, this message translates to:
  /// **'Bu işlem şu anda gerçekleştirilemiyor'**
  String get actionUnavailable;

  /// Title shown on the details screen when the pharmacy could not be loaded.
  ///
  /// In tr, this message translates to:
  /// **'Eczane bulunamadı'**
  String get pharmacyNotFound;

  /// Label for the on-duty-only filter toggle.
  ///
  /// In tr, this message translates to:
  /// **'Sadece Nöbetçi'**
  String get onDutyOnly;

  /// Action to reset search text, district, and on-duty filters.
  ///
  /// In tr, this message translates to:
  /// **'Filtreleri Temizle'**
  String get clearFilters;

  /// User-facing message for a network connectivity failure.
  ///
  /// In tr, this message translates to:
  /// **'İnternet bağlantısı yok. Lütfen bağlantınızı kontrol edip tekrar deneyin.'**
  String get errorNetwork;

  /// User-facing message for a request timeout.
  ///
  /// In tr, this message translates to:
  /// **'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.'**
  String get errorTimeout;

  /// User-facing message for a server-side error response.
  ///
  /// In tr, this message translates to:
  /// **'Sunucu tarafında bir sorun oluştu. Lütfen kısa süre sonra tekrar deneyin.'**
  String get errorServer;

  /// User-facing message for an unclassified error.
  ///
  /// In tr, this message translates to:
  /// **'Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.'**
  String get errorUnknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
