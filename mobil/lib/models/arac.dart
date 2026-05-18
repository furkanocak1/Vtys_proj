class Arac {
  const Arac({
    required this.aracId,
    required this.subeId,
    required this.markaId,
    required this.markaAdi,
    required this.model,
    required this.sasiNo,
    required this.yil,
    required this.fiyat,
    required this.durum,
  });

  final int aracId;
  final int subeId;
  final int markaId;
  final String markaAdi;
  final String model;
  final String sasiNo;
  final int yil;
  final double fiyat;
  final String durum;

  factory Arac.fromJson(Map<String, dynamic> json) {
    return Arac(
      aracId: json['aracId'] as int,
      subeId: json['subeId'] as int,
      markaId: json['markaId'] as int,
      markaAdi: json['markaAdi'] as String,
      model: json['model'] as String,
      sasiNo: json['sasiNo'] as String,
      yil: json['yil'] as int,
      fiyat: (json['fiyat'] as num).toDouble(),
      durum: json['durum'] as String,
    );
  }
}
