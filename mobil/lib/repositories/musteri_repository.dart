import '../models/musteri.dart';

abstract class MusteriRepository {
  Future<List<Musteri>> getMusteriler();
}
