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
      musteriId: json['musteriId'] as int,
      adSoyad: json['adSoyad'] as String,
      tcKimlik: json['tcKimlik'] as String,
      telefon: json['telefon'] as String,
      musteriTipi: json['musteriTipi'] as String,
    );
  }
}
