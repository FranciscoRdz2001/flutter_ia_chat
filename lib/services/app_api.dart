import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AppApi {
  static final _instance = AppApi._();

  factory AppApi() => _instance;

  AppApi._();

  static AppApi get instance => _instance;

  Future<T?> post<T>({
    required String url,
    Map<String, dynamic>? body,
    required T Function(Map<String, dynamic> data) mapper,
  }) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.post(uri, body: body);
      log(response.body);
      if (response.statusCode != 200) return null;
      final json = utf8.decode(response.bodyBytes);

      final data = mapper(jsonDecode(json));

      return data;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }
}
