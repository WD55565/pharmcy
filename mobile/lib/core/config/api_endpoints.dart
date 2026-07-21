/// Paths on the existing Spring Boot backend (`com.nobetcieczaneplus`).
/// Combined with [AppConfig.apiBaseUrl] by [DioClient] to form full request
/// URLs. Kept centralized so a backend route change is a one-line edit.
abstract final class ApiEndpoints {
  static const String pharmacies = '/pharmacies';
  static const String assistantChat = '/assistant/chat';

  static String pharmacyById(int id) => '$pharmacies/$id';
}
