import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorage<T> {
  LocalDataStorage(
      {required SharedPreferences preferences,
      required String key,
      required T Function(Map<String, dynamic>) fromJson})
      : _preferences = preferences,
        dataCollectionKey = key,
        _fromJson = fromJson {
    _init();
  }
  final T Function(Map<String, dynamic>) _fromJson;
  final SharedPreferences _preferences;

  final _controller = BehaviorSubject<List<T?>>.seeded([]);

  String dataCollectionKey;

  //initializing the actual stream controller with local storage value  on class creation
  void _init() async {
    final fetchData = _preferences.getString(dataCollectionKey);
    if (fetchData != null) {
      final dataList =
          List<Map<String, dynamic>>.from(jsonDecode(fetchData) as List);
      final data = dataList.map((e) => _fromJson(e)).toList();
      _controller.add(data);
    } else {
      _controller.add(const []);
    }
  }

  Stream<List<T?>> getData() => _controller.asBroadcastStream();

  Future<void> save(T data) async {
    final array = [..._controller.value];
    final copy = array.toSet().toList();
    print("value from cache : $copy");
    final dataIndex = copy.indexWhere((currentData) => currentData == data);
    if (dataIndex >= 0) {
      copy[dataIndex] = data;
    } else {
      copy.add(data);
    }
    print("Saved $T");
    _controller.add(copy);
    await _preferences.setString(
        dataCollectionKey, jsonEncode(_controller.value));
  }

  Future<void> clear() async => _controller.add([]);
  void dispose() => _controller.close();
}
