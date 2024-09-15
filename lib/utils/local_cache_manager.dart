import 'dart:convert';
import 'package:tikar/models/staff_model.dart';
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

  static Future<void> setUser(
      {required String key, required StaffModel value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(value.toJson()));
  }

  static Future<String?> getUser({required String key}) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }

  static Future<void> setToken(
      {required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(value));
  }

  static Future<String?> getToken(String key) async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(key);
  }
}
