import '../models/satis_kayit.dart';
import 'satis_repository.dart';

class SatisMockRepository implements SatisRepository {
  @override
  Future<void> kaydet(SatisKayit kayit) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    // Gerçekte DB trigger araç durumunu Satıldı yapar.
  }
}
