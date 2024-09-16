import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/models/rent_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RentCubit extends Cubit<List<RentModel>?>
    implements BaseCubit<RentCubit> {
  RentCubit() : super(null);
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
  void post(RentCubit data) {
    // TODO: implement post
  }

  @override
  void update(RentCubit data) {
    // TODO: implement update
  }
}
