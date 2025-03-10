import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:stldemo/constants/api_path.dart';
import 'package:stldemo/services/session_storage_service.dart';

class AuthService {
  static AuthService? service;

  static Future<AuthService?> getInstance() async {
    if (service == null) {
      service = AuthService();
    }
    return service;
  }

  Future<int> authenticateUser(String username, String password) async {
     var res = await http.post(ApiPath.KEYCLOAK_AUTH, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "username": username,
      "password": password,
      "client_id": "push-messenger",
      "grant_type": "password"
    });

    if (res.statusCode == 200) {
      var sessionStorageService = await SessionStorageService.getInstance();
      sessionStorageService.saveAccessToken(res.body);
      return res.statusCode;
    } else {
      debugPrint(
          "An Error Occurred during loggin in. Status code: ${res.statusCode} , body: ${res.body.toString()}");
      return res.statusCode;
    }
  }
}


