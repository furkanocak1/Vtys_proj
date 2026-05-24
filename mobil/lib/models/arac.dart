import '../utils/api_json.dart';

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
      aracId: ApiJson.intVal(json, 'aracId', 'AracID'),
      subeId: json.containsKey('SubeID') || json.containsKey('subeId')
          ? ApiJson.intVal(json, 'subeId', 'SubeID')
          : 0,
      markaId: json.containsKey('MarkaID') || json.containsKey('markaId')
          ? ApiJson.intVal(json, 'markaId', 'MarkaID')
          : 0,
      markaAdi: ApiJson.str(json, 'markaAdi', 'MarkaAdi'),
      model: ApiJson.str(json, 'model', 'Model'),
      sasiNo: ApiJson.str(json, 'sasiNo', 'SasiNo'),
      yil: ApiJson.intVal(json, 'yil', 'Yil'),
      fiyat: ApiJson.doubleVal(json, 'fiyat', 'Fiyat'),
      durum: ApiJson.str(json, 'durum', 'Durum'),
    );
  }
}
