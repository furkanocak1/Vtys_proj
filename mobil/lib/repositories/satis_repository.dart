import '../models/satis_kayit.dart';

abstract class SatisRepository {
  Future<void> kaydet(SatisKayit kayit);
}
