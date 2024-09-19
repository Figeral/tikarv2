import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/viewmodels/basement_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasementCubit extends Cubit<List<BasementModel?>?>
    implements BaseCubit<BasementModel> {
  BasementCubit() : super(null);
  final _basementVM = BasementVm();
  Future<LocalDataStorage<BasementModel>> get cache async =>
      LocalDataStorage<BasementModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "basement_key",
          fromJson: BasementModel.fromJson);

  @override
  void delete(int id) async {
    _basementVM.deleteData(id);
    final _cache = await cache;
    await _cache.clear();
    fetch();
  }

  @override
  void fetch() async {
    final data = await _basementVM.getData();
    final _cache = await cache;
    data.forEach((e) async {
      await _cache.save(e);
    });
    _cache.getData().listen((e) {
      emit(e);
    });
  }

  @override
  void fetchById(int id) {
    // TODO: implement fetchById
  }

  @override
  void post(BasementModel data) {
    _basementVM.postData(data);
  }

  @override
  void update(BasementModel data) {
    _basementVM.updateData(data);
  }

  Future<void> getData() async {
    final _cache = await cache;
    _cache.getData().listen((e) {
      emit(e);
    });
  }

  List<BasementModel?>? get basement => state;
}
