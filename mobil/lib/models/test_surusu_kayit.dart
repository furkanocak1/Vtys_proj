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
}
