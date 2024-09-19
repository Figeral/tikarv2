import 'package:tikar/cubits/base_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/viewmodels/staff_vm.dart';
import 'package:tikar/viewmodels/lessor_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikar/views/desktop/tikar/pages/lessor.dart';

class LessorCubit extends Cubit<List<LessorModel?>?>
    implements BaseCubit<LessorModel> {
  LessorCubit() : super(null);
  final _lessorVM = LessorVM();
  Future<LocalDataStorage<LessorModel>> get cache async =>
      LocalDataStorage<LessorModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "lessor_key",
          fromJson: LessorModel.fromJson);

  @override
  void delete(int id) async {
    _lessorVM.deleteData(id);
    final _cache = await cache;
    await _cache.clear();
    fetch();
  }

  @override
  void fetch() async {
    final data = await _lessorVM.getData();
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
  void post(LessorModel data) {
    _lessorVM.postData(data);
  }

  @override
  void update(LessorModel data) async {
    _lessorVM.updateData(data);
  }

  Future<void> getData() async {
    final _cache = await cache;
    _cache.getData().listen((e) {
      emit(e);
    });
  }

  List<LessorModel?>? get lessor => state;
}
