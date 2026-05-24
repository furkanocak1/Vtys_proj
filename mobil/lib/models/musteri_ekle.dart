class MusteriEkle {
  const MusteriEkle({
    required this.adSoyad,
    required this.tcKimlik,
    required this.telefon,
    required this.musteriTipi,
  });

  final String adSoyad;
  final String tcKimlik;
  final String telefon;
  final String musteriTipi;

  Map<String, dynamic> toJson() => {
        'adSoyad': adSoyad,
        'tcKimlik': tcKimlik,
        'telefon': telefon,
        'musteriTipi': musteriTipi,
      };

  /// web_db/backend/api.php
  Map<String, dynamic> toApiJson() => {
        'AdSoyad': adSoyad,
        'TCKimlik': tcKimlik,
        'Telefon': telefon,
        'MusteriTipi': musteriTipi,
      };
}
