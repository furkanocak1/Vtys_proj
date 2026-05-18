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

Mock ↔ API: `mobil/lib/config/app_config.dart` (`useMock`, `apiBaseUrl`).

Ekranlar: araç listesi → tıkla → araç detay.
