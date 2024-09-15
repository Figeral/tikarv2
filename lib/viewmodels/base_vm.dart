import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseVM<T> {
  final localCache = SharedPreferences.getInstance();
  Future<List<T>> getData();
  Future<T> getDataById(int id);
  void postData(T data);
  void updateData(T data);
  void deleteData(int id);
}
