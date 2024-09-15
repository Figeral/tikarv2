import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tikar/cubits/base_state.dart';
import 'package:tikar/models/staff_model.dart';
import 'package:tikar/viewmodels/user_vm.dart';

class UserCubit extends Cubit<StaffModel?> {
  UserCubit() : super(null);
  final _userVM = UserVM();
  Future<void> fetchData(String username, String pw) async {
    final token = await _userVM.loginUser(username: username, pw: pw);
    final user = await _userVM.fetchUserInfo(token: token);
    emit(user);
  }

  StaffModel? get user => state;
}
