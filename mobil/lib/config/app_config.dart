/// Mock ↔ gerçek API geçişi buradan yapılır.
class AppConfig {
  /// true  → sahte veri (AracMockRepository)
  /// false → PHP API (AracApiRepository)
  static const bool useMock = true;

  /// API hazır olunca web arkadaşının verdiği adres.
  /// Emülatör + bilgisayarda XAMPP: http://10.0.2.2/otogaleri/api
  /// Gerçek telefon + aynı Wi‑Fi: http://192.168.x.x/otogaleri/api
  static const String apiBaseUrl = 'http://10.0.2.2/otogaleri/api';
}
