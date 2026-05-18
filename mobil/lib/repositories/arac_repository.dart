import '../models/arac.dart';

abstract class AracRepository {
  Future<List<Arac>> getAraclar({String? durum});
}
