import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/viewmodels/staff_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffCubit extends Cubit<List<StaffModel>?>
    implements BaseCubit<StaffModel> {
  StaffCubit() : super(null) {
    _init();
  }
  void _init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    cache = LocalDataStorage<StaffModel>(
        preferences: sharedPreferences,
        key: "staff_key",
        fromJson: StaffModel.fromJson);
    print('INI5');
  }

  final _staffVM = StaffVM();
  late LocalDataStorage<StaffModel> cache;

  @override
  void delete(int id) async {
    // TODO: implement delete
  }

  @override
  void fetch() async {
    final data = await _staffVM.getData();
    data.forEach((e) async {
      print(" staff json : ${e.toJson()}");
      await cache.save(e);
    });
    emit(data);
  }

  @override
  void fetchById(int id) {
    // TODO: implement fetchById
  }

  @override
  void post(StaffModel data) {
    // TODO: implement post
  }

  @override
  void update(StaffModel data) {
    // TODO: implement update
  }
}
