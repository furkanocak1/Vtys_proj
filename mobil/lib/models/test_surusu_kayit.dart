class TestSurusuKayit {
  const TestSurusuKayit({
    required this.aracId,
    required this.musteriId,
    required this.personelId,
    this.notlar,
  });

  final int aracId;
  final int musteriId;
  final int personelId;
  final String? notlar;

  Map<String, dynamic> toJson() => {
        'aracId': aracId,
        'musteriId': musteriId,
        'personelId': personelId,
        if (notlar != null && notlar!.isNotEmpty) 'notlar': notlar,
      };

  /// api.php test kaydı için Tarih alanı zorunlu (POST ayrımı).
  Map<String, dynamic> toApiJson() {
    final now = DateTime.now();
    final tarih =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} '
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';
    return {
      'AracID': aracId,
      'MusteriID': musteriId,
      'Tarih': tarih,
      'Notlar': notlar ?? '',
    };
  }
}
