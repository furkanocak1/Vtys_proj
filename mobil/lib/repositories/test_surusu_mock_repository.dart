import '../models/test_surusu_kayit.dart';
import 'test_surusu_repository.dart';

class TestSurusuMockRepository implements TestSurusuRepository {
  @override
  Future<void> kaydet(TestSurusuKayit kayit) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
}
