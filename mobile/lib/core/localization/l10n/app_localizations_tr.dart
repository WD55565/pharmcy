// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Nöbetçi Eczane+';

  @override
  String get homeTitle => 'Ana Sayfa';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get errorTitle => 'Bir şeyler ters gitti';

  @override
  String get errorRetry => 'Tekrar Dene';

  @override
  String get emptyTitle => 'Sonuç bulunamadı';

  @override
  String get searchHint => 'Ad, ilçe veya adrese göre ara';

  @override
  String get districtAll => 'Tüm İlçeler';

  @override
  String get onDuty => 'Nöbetçi';

  @override
  String get notOnDuty => 'Nöbetçi Değil';

  @override
  String get openInMaps => 'Haritada Göster';

  @override
  String get mapsComingSoon => 'Harita entegrasyonu yakında eklenecek';

  @override
  String get noPharmaciesFound => 'Eczane bulunamadı';

  @override
  String get noPharmaciesFoundHint =>
      'Arama veya ilçe filtresini değiştirmeyi deneyin.';

  @override
  String get addressLabel => 'Adres';

  @override
  String get districtLabel => 'İlçe';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get dutyHoursLabel => 'Nöbet Saatleri';

  @override
  String get dutyHoursNotSpecified => 'Belirtilmemiş';

  @override
  String get callAction => 'Ara';

  @override
  String get shareAction => 'Paylaş';

  @override
  String get addToFavorites => 'Favorilere Ekle';

  @override
  String get removeFromFavorites => 'Favorilerden Çıkar';

  @override
  String get actionUnavailable => 'Bu işlem şu anda gerçekleştirilemiyor';

  @override
  String get pharmacyNotFound => 'Eczane bulunamadı';

  @override
  String get onDutyOnly => 'Sadece Nöbetçi';

  @override
  String get clearFilters => 'Filtreleri Temizle';

  @override
  String get errorNetwork =>
      'İnternet bağlantısı yok. Lütfen bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get errorTimeout =>
      'İstek zaman aşımına uğradı. Lütfen tekrar deneyin.';

  @override
  String get errorServer =>
      'Sunucu tarafında bir sorun oluştu. Lütfen kısa süre sonra tekrar deneyin.';

  @override
  String get errorUnknown =>
      'Beklenmeyen bir hata oluştu. Lütfen tekrar deneyin.';
}
