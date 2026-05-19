import '../models/musteri.dart';
import '../models/musteri_ekle.dart';

abstract class MusteriRepository {
  Future<List<Musteri>> getMusteriler();
  Future<Musteri> ekle(MusteriEkle kayit);
}
