/// Mock ↔ API geçişi buradan yapılır.
class AppConfig {
  /// true  → sahte veri | false → web_db PHP API
  static const bool useMock = false;

  /// XAMPP: web_db/backend/api.php
  /// Android emülatör: http://10.0.2.2/... | Edge/Windows: http://localhost/...
  static const String apiBaseUrl =
      'http://localhost/Vtys_proj/web_db/backend/api.php';

  static const int mockPersonelId = 1;
}
