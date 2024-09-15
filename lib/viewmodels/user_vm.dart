import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:tikar/models/staff_model.dart";
import "package:tikar/viewmodels/endpoint.dart";
import "package:tikar/utils/snackbar_messenger.dart";

class UserVM {
  Future<String> loginUser(
      {required String username, required String pw}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = <String, dynamic>{
      "username": username,
      "password": pw,
    };
    try {
      final response = await http.post(Uri.parse(Endpoint.login()),
          body: jsonEncode(body), headers: headers);
      print("${response.body}");
      if (response.statusCode == 202) {
        print("${response.body}");
        return response.body.trim();
      } else {
        throw Exception("account not found");
      }
    } catch (e) {
      print("${e.toString()}");
      throw Exception("something when wrong on endpoint");
    }
  }

  Future<StaffModel> fetchUserInfo({required String token}) async {
    final header = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
    try {
      final response =
          await http.get(Uri.parse(Endpoint.info()), headers: header);
      if (response.statusCode == 200) {
        return StaffModel.fromJson(
            jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception("Error on fetching user data");
      }
    } catch (e) {
      print("${e.toString()}");
      throw Exception("something when wrong on fetching user details");
    }
  }
}
///implement login functionalities with token as return value 
///implement fetch of user details an initialize state  
///implement user creation depending on authorities . At the moment of that i will implement an endpoint in the server for that 


