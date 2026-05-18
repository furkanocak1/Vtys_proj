import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/arac.dart';
import 'arac_repository.dart';

/// PHP API hazır olunca kullanılır.
/// Beklenen: GET {apiBaseUrl}/araclar.php  →  JSON dizi
class AracApiRepository implements AracRepository {
  AracApiRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<Arac>> getAraclar({String? durum}) async {
    final query = durum != null && durum.isNotEmpty ? '?durum=$durum' : '';
    final uri = Uri.parse('${AppConfig.apiBaseUrl}/araclar.php$query');

    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('API hata: ${response.statusCode}');
    }

    final list = jsonDecode(response.body) as List<dynamic>;
    return list
        .map((e) => Arac.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
