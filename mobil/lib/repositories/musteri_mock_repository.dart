import '../models/musteri.dart';
import 'musteri_repository.dart';

class MusteriMockRepository implements MusteriRepository {
  static const _data = [
    Musteri(
      musteriId: 1,
      adSoyad: 'Ahmet Yılmaz',
      tcKimlik: '12345678901',
      telefon: '05321234567',
      musteriTipi: 'Bireysel',
    ),
    Musteri(
      musteriId: 2,
      adSoyad: 'Kaya Otomotiv Ltd.',
      tcKimlik: '98765432109',
      telefon: '02125551234',
      musteriTipi: 'Kurumsal',
    ),
    Musteri(
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
}
