import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/viewmodels/asset_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetCubit extends Cubit<List<AssetModel?>?>
    implements BaseCubit<AssetModel> {
  AssetCubit() : super(null);
  final _assetVM = AssetVM();
  Future<LocalDataStorage<AssetModel>> get cache async =>
      LocalDataStorage<AssetModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "asset_key",
          fromJson: AssetModel.fromJson);

  @override
  void delete(int id) async {
    _assetVM.deleteData(id);
    final _cache = await cache;
    await _cache.clear();
    fetch();
  }

  @override
  void fetch() async {
    final data = await _assetVM.getData();
    final _cache = await cache;
    data.forEach((e) async {
      await _cache.save(e);
    });
    _cache.getData().listen((e) {
      emit(e);
    });
  }

  @override
  void fetchById(int id) {}

  @override
  void post(AssetModel data) {
    _assetVM.postData(data);
  }

  @override
  void update(AssetModel data) {
    _assetVM.updateData(data);
  }

  Future<List<AssetModel?>?> getData() async {
    final _cache = await cache;
    _cache.getData().listen((e) {
      emit(e);
    });
    return state;
  }

  List<AssetModel?>? get asset => state;
}
