import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:picory_app/utils/api_constants.dart';

class HttpService {

    String baseUrl = ApiConstants.baseUrl;

  /// Common Headers
  static Map<String, String> _headers({String? token}) {
    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  /// GET METHOD
   Future<dynamic> get(
      String endpoint, {
        String? token,
      }) async {

    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.get(
      url,
      headers: _headers(token: token),
    );

    return _handleResponse(response);
  }

  /// POST METHOD
   Future<dynamic> post(
      String endpoint, {
        Map<String, dynamic>? body,
        String? token,
      }) async {

    final url = Uri.parse("$baseUrl$endpoint");

    final response = await http.post(
      url,
      headers: _headers(token: token),
      body: jsonEncode(body),
    );

    return _handleResponse(response);
  }

  /// Response Handler
  static dynamic _handleResponse(http.Response response) {

    final jsonData = jsonDecode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonData;
    } else {
      throw Exception(jsonData["message"] ?? "API Error");
    }
  }
}