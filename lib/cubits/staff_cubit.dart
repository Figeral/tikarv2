import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/viewmodels/staff_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffCubit extends Cubit<List<StaffModel?>?>
    implements BaseCubit<StaffModel> {
  StaffCubit() : super(null) {}

  final _staffVM = StaffVM();
  Future<LocalDataStorage<StaffModel>> get cache async =>
      LocalDataStorage<StaffModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "staff_key",
          fromJson: StaffModel.fromJson);

  @override
  void delete(int id) async {
    _staffVM.deleteData(id);
    final _cache = await cache;
    await _cache.clear();
    fetch();
  }

  @override
  void fetch() async {
    final data = await _staffVM.getData();
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
  void post(StaffModel data) async {
    _staffVM.postData(data);
  }

  @override
  void update(StaffModel data) async {
    _staffVM.updateData(data);
  }

  Future<void> getData() async {
    final _cache = await cache;
    _cache.getData().listen((e) {
      emit(e);
    });
  }

  List<StaffModel?>? get staff => state;
}
