import '../models/arac.dart';
import '../services/api_client.dart';
import 'arac_repository.dart';

/// GET web_db/backend/api.php?tip=araclar[&durum=...]
class AracApiRepository implements AracRepository {
  AracApiRepository({ApiClient? client}) : _api = client ?? ApiClient();

  final ApiClient _api;

  @override
  Future<List<Arac>> getAraclar({String? durum}) async {
    final query = <String, String>{};
    if (durum != null && durum.isNotEmpty) {
      query['durum'] = durum;
    }
    final list = await _api.getList(tip: 'araclar', query: query.isEmpty ? null : query);
    return list.map((e) => Arac.fromJson(e as Map<String, dynamic>)).toList();
  }
}
