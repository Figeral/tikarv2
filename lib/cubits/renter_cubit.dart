import 'package:tikar/cubits/base_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/models/renter_model.dart';

class RenterCubit extends Cubit<List<RenterModel>?>
    implements BaseCubit<RenterModel> {
  RenterCubit() : super(null);
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
  void post(RenterModel data) {
    // TODO: implement post
  }

  @override
  void update(RenterModel data) {
    // TODO: implement update
  }
}
