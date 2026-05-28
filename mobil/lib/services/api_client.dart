import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Uri _uri({String? tip, Map<String, String>? query}) {
    final q = <String, String>{};
    if (tip != null) q['tip'] = tip;
    if (query != null) q.addAll(query);
    return Uri.parse(AppConfig.apiBaseUrl).replace(queryParameters: q);
  }

  Future<List<dynamic>> getList({String? tip, Map<String, String>? query}) async {
    final response = await _client.get(_uri(tip: tip, query: query));
    _throwIfHttpError(response);
    final decoded = jsonDecode(response.body);
    if (decoded is Map && decoded['hata'] != null) {
      throw Exception(decoded['hata'].toString());
    }
    return decoded as List<dynamic>;
  }

  Future<void> postJson(Map<String, dynamic> body) async {
    final response = await _client.post(
      _uri(),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    _throwIfHttpError(response);
    final decoded = jsonDecode(response.body);
    if (decoded is Map && decoded['durum'] == 'hata') {
      throw Exception(decoded['mesaj']?.toString() ?? 'İşlem başarısız');
    }
  }

  void _throwIfHttpError(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('API hata: ${response.statusCode}');
    }
  }
}
