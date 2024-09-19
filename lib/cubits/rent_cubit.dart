import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/models/rent_model.dart';
import 'package:tikar/viewmodels/rent_vm.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RentCubit extends Cubit<List<RentModel?>?>
    implements BaseCubit<RentModel> {
  RentCubit() : super(null);
  final _rentVM = RentVM();
  Future<LocalDataStorage<RentModel>> get cache async =>
      LocalDataStorage<RentModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "rent_key",
          fromJson: RentModel.fromJson);

  @override
  void delete(int id) async {
    _rentVM.deleteData(id);
    final _cache = await cache;
    await _cache.clear();
    fetch();
  }

  @override
  void fetch() async {
    final data = await _rentVM.getData();
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

  Future<void> getData() async {
    final _cache = await cache;
    _cache.getData().listen((e) {
      emit(e);
    });
  }

  List<RentModel?>? get rent => state;

  @override
  void post(RentModel data) {
    _rentVM.postData(data);
  }

  @override
  void update(RentModel data) {
    _rentVM.updateData(data);
  }
}
