import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/test_surusu_kayit.dart';
import 'test_surusu_repository.dart';

/// Beklenen: POST {apiBaseUrl}/test-surusleri.php
class TestSurusuApiRepository implements TestSurusuRepository {
  TestSurusuApiRepository({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<void> kaydet(TestSurusuKayit kayit) async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}/test-surusleri.php');
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
