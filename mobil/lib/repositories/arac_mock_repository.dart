import '../models/arac.dart';
import 'arac_repository.dart';

/// Veritabanı / PHP hazır olmadan ekranları test etmek için.
class AracMockRepository implements AracRepository {
  static final List<Arac> _data = [
    const Arac(
      aracId: 1,
      subeId: 1,
      markaId: 1,
      markaAdi: 'Toyota',
      model: 'Corolla',
      sasiNo: 'JTDBR32E720001234',
      yil: 2022,
      fiyat: 850000,
      durum: 'Satışta',
    ),
    const Arac(
      aracId: 2,
      subeId: 1,
      markaId: 2,
      markaAdi: 'Volkswagen',
      model: 'Golf',
      sasiNo: 'WVWZZZ1KZBW123456',
      yil: 2021,
      fiyat: 920000,
      durum: 'Satışta',
    ),
    const Arac(
      aracId: 3,
      subeId: 2,
      markaId: 3,
      markaAdi: 'Renault',
      model: 'Clio',
      sasiNo: 'VF1RJ0B0634567890',
      yil: 2020,
      fiyat: 520000,
      durum: 'Rezerve',
    ),
    const Arac(
      aracId: 4,
      subeId: 1,
      markaId: 1,
      markaAdi: 'Toyota',
      model: 'Yaris',
      sasiNo: 'JTDKN3DU5A0123456',
      yil: 2019,
      fiyat: 610000,
      durum: 'Satıldı',
    ),
  ];

  @override
  Future<List<Arac>> getAraclar({String? durum}) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (durum == null || durum.isEmpty) return List.unmodifiable(_data);
    return _data.where((a) => a.durum == durum).toList();
  }
}
