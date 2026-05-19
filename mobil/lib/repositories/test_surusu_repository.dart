import '../models/test_surusu_kayit.dart';

abstract class TestSurusuRepository {
  Future<void> kaydet(TestSurusuKayit kayit);
}
