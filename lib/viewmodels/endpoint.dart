import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Endpoint {
  static final localCache = SharedPreferences.getInstance();
  static String login() => "https://tikar-server.onrender.com/account/login";
  static String signIn() => "https://tikar-server.onrender.com/account/signin";
  static String info() => "https://tikar-server.onrender.com/account/info";
  static String api() => "https://tikar-server.onrender.com/api/";

  static Future<String?> get token async {
    final local = await localCache;
    return local.getString("user_token");
  }

  static Future<Map<String, String>> get header async => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${jsonDecode((await token)!)}',
      };
}
