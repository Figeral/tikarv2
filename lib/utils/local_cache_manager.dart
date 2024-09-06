import 'package:shared_preferences/shared_preferences.dart';

class LocalCacheManager {
  static Future<void> setFlag(
      {required String name, required bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(name, value);
  }

  static Future<bool?> getFlag({required String name}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool(name);
  }
}
