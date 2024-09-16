import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Endpoint {
  static final localCache = SharedPreferences.getInstance();
  static String login() => "http://localhost:8080/account/login";
  static String info() => "http://localhost:8080/account/info";
  static String api() => "http://localhost:8080/api/";

  static Future<String?> get token async {
    final local = await localCache;
    return local.getString("user_token");
  }

  static Future<Map<String, String>> get header async => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${jsonDecode((await token)!)}',
      };
}
