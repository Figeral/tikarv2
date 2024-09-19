import 'package:tikar/cubits/base_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:tikar/viewmodels/renter_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RenterCubit extends Cubit<List<RenterModel?>?>
    implements BaseCubit<RenterModel> {
  RenterCubit() : super(null);
  final _renterVM = RenterVM();
  Future<LocalDataStorage<RenterModel>> get cache async =>
      LocalDataStorage<RenterModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "renter_key",
          fromJson: RenterModel.fromJson);
  @override
  void delete(int id) async {
    _renterVM.deleteData(id);
    final _cache = await cache;
    await _cache.clear();
    fetch();
  }

  @override
  void fetch() async {
    final data = await _renterVM.getData();
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
  void post(RenterModel data) async {
    _renterVM.postData(data);
  }

  @override
  void update(RenterModel data) async {
    _renterVM.updateData(data);
  }

  Future<void> getData() async {
    final _cache = await cache;
    _cache.getData().listen((e) {
      emit(e);
    });
  }

  List<RenterModel?>? get renter => state;
}
