import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:tikar/models/staff_model.dart';
import 'package:tikar/viewmodels/base_vm.dart';
import 'package:tikar/viewmodels/endpoint.dart';

class StaffVM extends BaseVM<StaffModel> {
  final endpoint = Endpoint.api();

  @override
  void deleteData(int id) async {
    final header = await Endpoint.header;
    try {
      final response = await http.delete(Uri.parse("${endpoint}staff/$id"));
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}staff/$id"));
    }
  }

  @override
  Future<List<StaffModel>> getData() async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}staffs"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
        return body.map((data) => StaffModel.fromJson(data)).toList();
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}staff}"));
    }
  }

  @override
  Future<StaffModel> getDataById(int id) async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}staff/$id"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return StaffModel.fromJson(body);
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}staff"));
    }
  }

  @override
  void postData(StaffModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}staff"),
          body: data.toJsonWithoutId(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}staff"));
    }
  }

  @override
  void updateData(StaffModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}staff"),
          body: data.toJson(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}staff"));
    }
  }
}
