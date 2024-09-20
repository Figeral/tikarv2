import 'package:tikar/cubits/base_cubit.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tikar/utils/local_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenCubit extends Cubit<BaseState> {
  ScreenCubit() : super(Initial());
  void get boardingScreen async {
    emit(Loading());
    bool isFlag =
        await LocalCacheManager.getFlag(name: "onboarding_finished") != null;
    if (isFlag) {
      emit(Success(isFlag));
    } else {
      emit(NotFound());
    }
  }

  void get authScreen async {
    emit(Loading());
    bool? isTokenPresent =
        await LocalCacheManager.getToken("user_token") != null;
    if (isTokenPresent) {
      emit(Success(isTokenPresent));
    } else {
      emit(NotFound());
    }
  }
}
