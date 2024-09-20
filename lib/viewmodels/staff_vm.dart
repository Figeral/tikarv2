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

    final response =
        await http.delete(Uri.parse("${endpoint}staff/$id"), headers: header);
  }

  @override
  Future<List<StaffModel>> getData() async {
    final header = await Endpoint.header;

    final response =
        await http.get(Uri.parse("${endpoint}staffs"), headers: header);
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      print(body);
      return body
          .map((data) => StaffModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } else {
      throw HttpException("HTTP ${response.statusCode}: ${response.body}",
          uri: Uri.parse("${endpoint}staffs"));
    }
  }

  @override
  Future<StaffModel> getDataById(int id) async {
    final header = await Endpoint.header;

    final response =
        await http.get(Uri.parse("${endpoint}staff/$id"), headers: header);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return StaffModel.fromJson(body);
    } else {
      throw HttpException("HTTP ${response.statusCode}: ${response.body}",
          uri: Uri.parse("${endpoint}staff/{$id}"));
    }
  }

  @override
  void postData(StaffModel data) async {
    final header = await Endpoint.header;
    final endpoint = Endpoint.signIn();

    final response = await http.post(Uri.parse(endpoint),
        body: jsonEncode(data.toJsonWithoutId()), headers: header);
    if (response.statusCode.toString().startsWith("2")) {
      print('success');
    }
  }

  @override
  void updateData(StaffModel data) async {
    final header = await Endpoint.header;

    final response = await http.post(Uri.parse("${endpoint}staff"),
        body: jsonEncode(data.toJson()), headers: header);
  }
}
