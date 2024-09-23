import 'dart:io';
import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/models/rent_model.dart';
import 'package:tikar/viewmodels/rent_vm.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RentCubit extends Cubit<BaseState<List<RentModel?>?>>
    implements BaseCubit<RentModel> {
  RentCubit() : super(Initial());
  final _rentVM = RentVM();
  Future<LocalDataStorage<RentModel>> get cache async =>
      LocalDataStorage<RentModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "rent_key",
          fromJson: RentModel.fromJson);

  @override
  void delete(int id) async {
    emit(Loading());
    try {
      _rentVM.deleteData(id);
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
    final data = await _rentVM.getData();
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

  @override
  void post(RentModel data) {
    emit(Loading());
    try {
      _rentVM.postData(data);
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
  void update(RentModel data) {
    emit(Loading());
    try {
      _rentVM.updateData(data);
      emit(Valid());
    } catch (e) {
      if (e is FormatException) {
        emit(Error(e.message));
      } else if (e is HttpException) {
        emit(Error(e.message));
      }
    }
  }
}
