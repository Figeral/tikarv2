import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/models/asset_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BasementCubit extends Cubit<List<BasementModel>?>
    implements BaseCubit<BasementModel> {
  BasementCubit() : super(null);
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
  void post(BasementModel data) {
    // TODO: implement post
  }

  @override
  void update(BasementModel data) {
    // TODO: implement update
  }
}
