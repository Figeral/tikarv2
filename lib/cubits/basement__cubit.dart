import 'dart:io';
import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/viewmodels/basement_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasementCubit extends Cubit<BaseState<List<BasementModel?>?>>
    implements BaseCubit<BasementModel> {
  BasementCubit() : super(Initial());
  final _basementVM = BasementVm();
  Future<LocalDataStorage<BasementModel>> get cache async =>
      LocalDataStorage<BasementModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "basement_key",
          fromJson: BasementModel.fromJson);

  @override
  void delete(int id) async {
    emit(Loading());
    try {
      _basementVM.deleteData(id);
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
    final data = await _basementVM.getData();
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
  void post(BasementModel data) {
    emit(Loading());
    try {
      _basementVM.postData(data);
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
  void update(BasementModel data) {
    emit(Loading());
    try {
      _basementVM.updateData(data);
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
