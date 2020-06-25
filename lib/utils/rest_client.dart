import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class RestClient {
  static const BASE_URL = 'http://notes.titanus.cz/public/api';
  final JsonDecoder decoder = JsonDecoder();

  processResponse(http.Response response) {
    final String res = response.body;
    final int statusCode = response.statusCode;

    if (statusCode >= 400) {
      throw Exception(
          'Error while fetching data, the status code was: $statusCode, body: $res');
    }
    return decoder.convert(res);
  }

  Future<dynamic> get(String uri, {Map<String, String> headers}) {
    return http.get(BASE_URL + uri, headers: headers).then(processResponse);
  }

  Future<dynamic> post(String uri, {Map<String, String> headers, body}) {
    return http
        .post(BASE_URL + uri, body: body, headers: headers)
        .then(processResponse);
  }

  Future<dynamic> put(String uri, {Map<String, String> headers, body}) {
    return http
        .put(BASE_URL + uri, body: body, headers: headers)
        .then(processResponse);
  }

  Future<dynamic> delete(String uri, {Map<String, String> headers}) {
    return http.delete(BASE_URL + uri, headers: headers).then(processResponse);
  }
}
