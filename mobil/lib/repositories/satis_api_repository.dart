import '../models/satis_kayit.dart';
import '../services/api_client.dart';
import 'satis_repository.dart';

class SatisApiRepository implements SatisRepository {
  SatisApiRepository({ApiClient? client}) : _api = client ?? ApiClient();

  final ApiClient _api;

  @override
  Future<void> kaydet(SatisKayit kayit) async {
    await _api.postJson(kayit.toApiJson());
  }
}
