import '../models/musteri.dart';
import '../models/musteri_ekle.dart';
import '../services/api_client.dart';
import 'musteri_repository.dart';

class MusteriApiRepository implements MusteriRepository {
  MusteriApiRepository({ApiClient? client}) : _api = client ?? ApiClient();

  final ApiClient _api;

  @override
  Future<List<Musteri>> getMusteriler() async {
    final list = await _api.getList(tip: 'musteriler');
    return list.map((e) => Musteri.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<Musteri> ekle(MusteriEkle kayit) async {
    await _api.postJson(kayit.toApiJson());
    final list = await getMusteriler();
    return list.firstWhere((m) => m.tcKimlik == kayit.tcKimlik);
  }
}
