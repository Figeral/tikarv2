import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/viewmodels/staff_vm.dart';
import 'package:tikar/viewmodels/lessor_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikar/views/desktop/tikar/pages/lessor.dart';

class LessorCubit extends Cubit<BaseState<List<LessorModel?>?>>
    implements BaseCubit<LessorModel> {
  LessorCubit() : super(Initial());
  final _lessorVM = LessorVM();
  Future<LocalDataStorage<LessorModel>> get cache async =>
      LocalDataStorage<LessorModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "lessor_key",
          fromJson: LessorModel.fromJson);

  @override
  void delete(int id) async {
    emit(Loading());
    try {
      _lessorVM.deleteData(id);
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
    final data = await _lessorVM.getData();
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
  void fetchById(int id) {}

  @override
  void post(LessorModel data) {
    emit(Loading());
    try {
      _lessorVM.postData(data);
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
  void update(LessorModel data) async {
    emit(Loading());
    try {
      _lessorVM.updateData(data);
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
      }
    });
  }
}
