import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:stldemo/models/token_model.dart';

class SessionStorageService {
  static SessionStorageService? _manager;
  static SharedPreferences? _prefs;
  static const String ACCESS_TOKEN_KEY = "ACCESS_TOKEN";

  static Future<SessionStorageService> getInstance() async {
    if (_manager == null || _prefs == null) {
      _manager = SessionStorageService();
      _prefs = await SharedPreferences.getInstance();
    }
    return _manager!;
  }

  void saveAccessToken(String accessToken) {
    var tokenModel = TokenModel(accessToken: accessToken, notBeforePolicy: null, tokenType: '', scope: '', sessionState: '');
    _prefs?.setString(ACCESS_TOKEN_KEY, jsonEncode(tokenModel.toJson()));
  }

  String? retrieveAccessToken() {
    var tokenJson = _prefs?.getString(ACCESS_TOKEN_KEY);
    if (tokenJson == null) {
      return null;
    }
    return TokenModel.fromJson(jsonDecode(tokenJson)).accessToken;
  }
}

