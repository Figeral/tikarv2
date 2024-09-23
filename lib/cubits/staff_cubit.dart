import 'dart:io';
import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/viewmodels/staff_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffCubit extends Cubit<BaseState<List<StaffModel?>?>>
    implements BaseCubit<StaffModel> {
  StaffCubit() : super(Initial());

  final _staffVM = StaffVM();
  Future<LocalDataStorage<StaffModel>> get cache async =>
      LocalDataStorage<StaffModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "staff_key",
          fromJson: StaffModel.fromJson);

  @override
  void delete(int id) async {
    emit(Loading());
    try {
      _staffVM.deleteData(id);
      final _cache = await cache;
      await _cache.clearAt(id);
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
  void fetch() async {
    emit(Loading());
    final data = await _staffVM.getData();
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
  void post(StaffModel data) async {
    emit(Loading());
    try {
      _staffVM.postData(data);
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
  void update(StaffModel data) async {
    emit(Loading());
    try {
      _staffVM.updateData(data);
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
    final _cache = await cache;
    _cache.getData().listen((e) {
      if (e.isNotEmpty) {
        emit(Success(e));
      } else {
        emit(NotFound());
        fetch();
      }
    });
  }
}
