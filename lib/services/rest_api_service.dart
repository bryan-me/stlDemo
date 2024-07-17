import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stldemo/models/api_response.dart';
import 'package:stldemo/services/session_storage_service.dart';

class RestApiService {
  static RestApiService? _service;

  static Future<RestApiService> getInstance() async {
    _service ??= RestApiService();
    return _service!;
  }

  Future<ApiResponse<T>> apiGetSecured<T>(
      Uri uri, T Function(Map<String, dynamic>) fromJson) async {
    final headers = await createAuthHeader();
    if (headers == null) {
      // Adjust response to provide a default or appropriate value for ApiResponse<T>
      return ApiResponse<T>(body: defaultResponseBody<T>(), code: 401);
    }
    final response = await http.get(uri, headers: headers);
    return parseResponse<T>(response, fromJson);
  }

  Future<ApiResponse<T>> apiGetNotSecured<T>(
      Uri uri, T Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(uri);
    return parseResponse<T>(response, fromJson);
  }

ApiResponse<T> parseResponse<T>(
      http.Response response, T Function(Map<String, dynamic>) fromJson) {
    if (response.statusCode == 200) {
      final parsedBody = deserialize<T>(response.body, fromJson);
      return ApiResponse<T>(
        body: parsedBody ?? defaultResponseBody<T>(), // Handle nullable parsedBody
        code: response.statusCode,
      );
    } else {
      final requestFailedMsg =
          "Failed to fetch data from: ${response.request!.url}";
      debugPrint(requestFailedMsg);
      return ApiResponse<T>(
        body: defaultResponseBody<T>(), // Provide default or appropriate value
        code: response.statusCode,
      );
    }
  }

  T? deserialize<T>(
    String json,
    T Function(Map<String, dynamic>) factory,
  ) {
    try {
      return factory(jsonDecode(json));
    } catch (e) {
      debugPrint('Error parsing JSON: $e');
      return null; // Adjust return based on your error handling strategy
    }
  }

  Future<Map<String, String>?>? createAuthHeader() async {
    var sessionStorageService = await SessionStorageService.getInstance();
    var accessToken = sessionStorageService.retrieveAccessToken();
    if (accessToken == null) {
      debugPrint("No access token in local storage found. Please log in.");
      return null;
    }
    return {"Authorization": "Bearer $accessToken"};
  }

  // Define a method to return a default or appropriate value for ApiResponse<T>
  T defaultResponseBody<T>() {
    // You can return null or any default value depending on your application's needs
    return null as T; // Here we return null as an example; adjust as per your requirements
  }
}