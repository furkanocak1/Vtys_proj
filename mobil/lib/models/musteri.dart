import '../utils/api_json.dart';

class Musteri {
  const Musteri({
    required this.musteriId,
    required this.adSoyad,
    required this.tcKimlik,
    required this.telefon,
    required this.musteriTipi,
  });

  final int musteriId;
  final String adSoyad;
  final String tcKimlik;
  final String telefon;
  final String musteriTipi;

  factory Musteri.fromJson(Map<String, dynamic> json) {
    return Musteri(
      musteriId: ApiJson.intVal(json, 'musteriId', 'MusteriID'),
      adSoyad: ApiJson.str(json, 'adSoyad', 'AdSoyad'),
      tcKimlik: ApiJson.str(json, 'tcKimlik', 'TCKimlik'),
      telefon: ApiJson.str(json, 'telefon', 'Telefon'),
      musteriTipi: ApiJson.str(json, 'musteriTipi', 'MusteriTipi'),
    );
  }
}
