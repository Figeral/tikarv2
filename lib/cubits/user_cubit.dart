import 'dart:convert';
import 'dart:isolate';
import 'package:bloc/bloc.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:tikar/viewmodels/user_vm.dart';
import 'package:tikar/utils/local_cache_manager.dart';

class UserCubit extends Cubit<StaffModel?> {
  UserCubit() : super(null);
  final _userVM = UserVM();
  Future<void> fetchData(String username, String pw) async {
    final token = await _userVM.loginUser(username: username, pw: pw);
    await LocalCacheManager.setToken(key: "user_token", value: token);
    final user = await _userVM.fetchUserInfo(token: token);
    await LocalCacheManager.setUser(key: "user_detail", value: user);
    emit(user);
  }

  void userInit() async {
    final user = await LocalCacheManager.getUser(key: "user_detail");
    emit(StaffModel.fromJson(jsonDecode(user!)));
  }

  StaffModel? get user {
    return state;
  }
}
