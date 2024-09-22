import 'dart:io';
import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:tikar/viewmodels/renter_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RenterCubit extends Cubit<BaseState<List<RenterModel?>?>>
    implements BaseCubit<RenterModel> {
  RenterCubit() : super(Initial());
  final _renterVM = RenterVM();
  Future<LocalDataStorage<RenterModel>> get cache async =>
      LocalDataStorage<RenterModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "renter_key",
          fromJson: RenterModel.fromJson);
  @override
  void delete(int id) async {
    emit(Loading());
    try {
      _renterVM.deleteData(id);
      emit(Valid());
    } catch (e) {
      if (e is FormatException) {
        emit(Error(e.message));
      } else if (e is HttpException) {
        emit(Error(e.message));
      }
    }
    final _cache = await cache;
    await _cache.clearAt(id);
  }

  @override
  void fetch() async {
    emit(Loading());
    final data = await _renterVM.getData();
    if (data.isNotEmpty) {
      final _cache = await cache;
      data.forEach((e) async {
        await _cache.save(e);
      });
      _cache.getData().listen((e) {
        emit(Success(e));
      });
    } else {
      emit(NotFound());
    }
  }

  @override
  void fetchById(int id) {
    // TODO: implement fetchById
  }

  @override
  void post(RenterModel data) async {
    print("inside print");
    emit(Loading());
    try {
      _renterVM.postData(data);
      emit(Valid());
    } catch (e) {
      if (e is FormatException) {
        emit(Error(e.message));
      } else if (e is HttpException) {
        emit(Error(e.message));
      }
    }
  }

  @override
  void update(RenterModel data) async {
    emit(Loading());
    try {
      _renterVM.updateData(data);
      emit(Valid());
    } catch (e) {
      if (e is FormatException) {
        emit(Error(e.message));
      } else if (e is HttpException) {
        emit(Error(e.message));
      }
    }
  }

  Future<void> getData() async {
    emit(Loading());
    final _cache = await cache;
    _cache.getData().listen((e) {
      if (e.isNotEmpty) {
        emit(Success(e));
      } else {
        emit(NotFound());
        fetch();
        //  print("inside getUser");
      }
    });
  }
}
