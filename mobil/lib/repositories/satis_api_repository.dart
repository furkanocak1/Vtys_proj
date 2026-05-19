import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/satis_kayit.dart';
import 'satis_repository.dart';

/// Beklenen: POST {apiBaseUrl}/satislar.php  →  body: JSON
class SatisApiRepository implements SatisRepository {
  SatisApiRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<void> kaydet(SatisKayit kayit) async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}/satislar.php');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(kayit.toJson()),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API hata: ${response.statusCode}');
    }
  }
}
