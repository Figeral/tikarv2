import 'dart:io';
import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/viewmodels/asset_vm.dart';
import 'package:tikar/data/local_data_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetCubit extends Cubit<BaseState<List<AssetModel?>?>>
    implements BaseCubit<AssetModel> {
  AssetCubit() : super(Initial());
  final _assetVM = AssetVM();
  Future<LocalDataStorage<AssetModel>> get cache async =>
      LocalDataStorage<AssetModel>(
          preferences: await SharedPreferences.getInstance(),
          key: "asset_key",
          fromJson: AssetModel.fromJson);

  @override
  void delete(int id) async {
    emit(Loading());
    try {
      _assetVM.deleteData(id);
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
    final data = await _assetVM.getData();
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
  void post(AssetModel data) {
    emit(Loading());
    try {
      _assetVM.postData(data);
      emit(Valid());
    } catch (e) {
      emit(Error("error occured"));
      if (e is FormatException) {
        emit(Error(e.message));
      } else if (e is HttpException) {
        emit(Error(e.message));
      }
    }
  }

  @override
  void update(AssetModel data) {
    emit(Loading());
    try {
      _assetVM.updateData(data);
      emit(Valid());
    } catch (e) {
      if (e is FormatException) {
        emit(Error(e.message));
      } else if (e is HttpException) {
        emit(Error(e.message));
      }
    }
  }

  Future<List<AssetModel?>?> getData() async {
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
