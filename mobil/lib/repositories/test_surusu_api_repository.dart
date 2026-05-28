import '../models/test_surusu_kayit.dart';
import '../services/api_client.dart';
import 'test_surusu_repository.dart';

class TestSurusuApiRepository implements TestSurusuRepository {
  TestSurusuApiRepository({ApiClient? client}) : _api = client ?? ApiClient();

  final ApiClient _api;

  @override
  Future<void> kaydet(TestSurusuKayit kayit) async {
    await _api.postJson(kayit.toApiJson());
  }
}
