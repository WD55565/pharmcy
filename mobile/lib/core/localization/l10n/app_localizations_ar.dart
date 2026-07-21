// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Nöbetçi Eczane+';

  @override
  String get homeTitle => 'الرئيسية';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get errorTitle => 'حدث خطأ ما';

  @override
  String get errorRetry => 'إعادة المحاولة';

  @override
  String get emptyTitle => 'لا توجد نتائج';

  @override
  String get searchHint => 'ابحث بالاسم أو المنطقة أو العنوان';

  @override
  String get districtAll => 'كل المناطق';

  @override
  String get onDuty => 'مناوبة';

  @override
  String get notOnDuty => 'غير مناوبة';

  @override
  String get openInMaps => 'عرض على الخريطة';

  @override
  String get mapsComingSoon => 'ستتوفر ميزة الخرائط قريبًا';

  @override
  String get noPharmaciesFound => 'لم يتم العثور على صيدليات';

  @override
  String get noPharmaciesFoundHint => 'حاول تعديل البحث أو فلتر المنطقة.';

  @override
  String get addressLabel => 'العنوان';

  @override
  String get districtLabel => 'المنطقة';

  @override
  String get phoneLabel => 'الهاتف';

  @override
  String get dutyHoursLabel => 'ساعات المناوبة';

  @override
  String get dutyHoursNotSpecified => 'غير محدد';

  @override
  String get callAction => 'اتصال';

  @override
  String get shareAction => 'مشاركة';

  @override
  String get addToFavorites => 'إضافة إلى المفضلة';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get actionUnavailable => 'هذا الإجراء غير متاح حاليًا';

  @override
  String get pharmacyNotFound => 'الصيدلية غير موجودة';

  @override
  String get onDutyOnly => 'المناوبة فقط';

  @override
  String get clearFilters => 'مسح الفلاتر';

  @override
  String get errorNetwork =>
      'لا يوجد اتصال بالإنترنت. يرجى التحقق من اتصالك والمحاولة مرة أخرى.';

  @override
  String get errorTimeout => 'انتهت مهلة الطلب. يرجى المحاولة مرة أخرى.';

  @override
  String get errorServer =>
      'حدثت مشكلة من جانبنا. يرجى المحاولة مرة أخرى بعد قليل.';

  @override
  String get errorUnknown => 'حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى.';
}
