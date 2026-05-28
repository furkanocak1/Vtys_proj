/// Personelin sisteme girdiği satış kaydı (müşteri alışverişi değil).
class SatisKayit {
  const SatisKayit({
    required this.aracId,
    required this.musteriId,
    required this.personelId,
    required this.satisFiyati,
  });

  final int aracId;
  final int musteriId;
  final int personelId;
  final double satisFiyati;

  Map<String, dynamic> toJson() => {
        'aracId': aracId,
        'musteriId': musteriId,
        'personelId': personelId,
        'satisFiyati': satisFiyati,
      };

  Map<String, dynamic> toApiJson() => {
        'AracID': aracId,
        'MusteriID': musteriId,
        'SatisFiyati': satisFiyati,
      };
}
