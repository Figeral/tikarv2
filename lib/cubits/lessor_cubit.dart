import 'package:tikar/cubits/base_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/models/lessor_model.dart';

class LessorCubit extends Cubit<List<LessorModel>?>
    implements BaseCubit<LessorModel> {
  LessorCubit() : super(null);
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
  void post(LessorModel data) {
    // TODO: implement post
  }

  @override
  void update(LessorModel data) {
    // TODO: implement update
  }
}
