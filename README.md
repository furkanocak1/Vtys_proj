# Otogaleri Projesi (TBL331)

| Klasör | Kim | Açıklama |
|--------|-----|----------|
| `veritabani/` | DB | SQL betikleri, ER diyagramı |
| `web/` | Web | PHP site + JSON API |
| `mobil/` | Mobil | Flutter uygulama |

## Mimari

```
mobil  ──HTTP(JSON)──►  web (PHP API)  ──SQL──►  veritabani
web arayüzü  ─────────────────────────────SQL──►  veritabani
```

Parçalar ayrı klasörlerde gelişir; sonunda **API adresi + JSON alanları** ile birleşir.

## Mobil kurulum

Flutter kur: https://docs.flutter.dev/get-started/install/windows

```bash
cd mobil
flutter create . --project-name otogaleri_mobile
flutter pub get
flutter run
```

API: `mobil/lib/config/app_config.dart` → `useMock = false`, `apiBaseUrl` = `web_db/backend/api.php` (XAMPP açık olmalı). Emülatörde `localhost` yerine `10.0.2.2` kullan.

Ekranlar: Araçlar / Müşteriler (+ ekle) / Test sürüşü / Satış kaydı, araç detay.
