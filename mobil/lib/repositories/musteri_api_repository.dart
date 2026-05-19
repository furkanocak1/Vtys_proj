import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/musteri.dart';
import '../models/musteri_ekle.dart';
import 'musteri_repository.dart';

/// Beklenen: GET {apiBaseUrl}/musteriler.php  →  JSON dizi
class MusteriApiRepository implements MusteriRepository {
  MusteriApiRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<Musteri>> getMusteriler() async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}/musteriler.php');
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw Exception('API hata: ${response.statusCode}');
    }

    final list = jsonDecode(response.body) as List<dynamic>;
    return list
        .map((e) => Musteri.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Musteri> ekle(MusteriEkle kayit) async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}/musteriler.php');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kayit.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API hata: ${response.statusCode}');
    }

    return Musteri.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  }
}
