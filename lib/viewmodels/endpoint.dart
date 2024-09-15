import 'package:shared_preferences/shared_preferences.dart';

class Endpoint {
  static final localCache = SharedPreferences.getInstance();
  static String login() =>
      "https://tikarserver-production.up.railway.app/account/login";
  static String info() =>
      "https://tikarserver-production.up.railway.app/account/info";
  static String api() => "https://tikarserver-production.up.railway.app/api/";

  static Future<String?> get token async {
    final local = await localCache;
    return local.getString("user_token");
  }

  static Future<Map<String, String>> get header async => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await token}',
      };
}
