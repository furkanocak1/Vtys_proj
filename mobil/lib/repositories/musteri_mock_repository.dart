import '../models/musteri.dart';
import '../models/musteri_ekle.dart';
import 'musteri_repository.dart';

class MusteriMockRepository implements MusteriRepository {
  static final List<Musteri> _data = [
    const Musteri(
      musteriId: 1,
      adSoyad: 'Ahmet Yılmaz',
      tcKimlik: '12345678901',
      telefon: '05321234567',
      musteriTipi: 'Bireysel',
    ),
    const Musteri(
      musteriId: 2,
      adSoyad: 'Kaya Otomotiv Ltd.',
      tcKimlik: '98765432109',
      telefon: '02125551234',
      musteriTipi: 'Kurumsal',
    ),
    const Musteri(
      musteriId: 3,
      adSoyad: 'Elif Demir',
      tcKimlik: '11223344556',
      telefon: '05449876543',
      musteriTipi: 'Bireysel',
    ),
  ];

  @override
  Future<List<Musteri>> getMusteriler() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_data);
  }

  @override
  Future<Musteri> ekle(MusteriEkle kayit) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    if (_data.any((m) => m.tcKimlik == kayit.tcKimlik)) {
      throw Exception('Bu TC kimlik numarası zaten kayıtlı');
    }

    final yeni = Musteri(
      musteriId: _data.isEmpty ? 1 : _data.last.musteriId + 1,
      adSoyad: kayit.adSoyad,
      tcKimlik: kayit.tcKimlik,
      telefon: kayit.telefon,
      musteriTipi: kayit.musteriTipi,
    );
    _data.add(yeni);
    return yeni;
  }
}
