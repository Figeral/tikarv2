import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetCubit extends Cubit<List<AssetModel>?>
    implements BaseCubit<AssetModel> {
  AssetCubit() : super(null);
  @override
  void delete(int id) {
    // TODO: implement delete
  }

  @override
  void fetch() {
    // TODO: implement fetch
  }

  @override
  void fetchById(int id) {
    // TODO: implement fetchById
  }

  @override
  void post(AssetModel data) {
    // TODO: implement post
  }

  @override
  void update(AssetModel data) {
    // TODO: implement update
  }
}
