import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:tikar/viewmodels/base_vm.dart';
import 'package:tikar/models/lessor_model.dart';
import 'package:tikar/viewmodels/endpoint.dart';

class LessorVM extends BaseVM<LessorModel> {
  final endpoint = Endpoint.api();
  @override
  void deleteData(int id) async {
    final header = await Endpoint.header;
    try {
      final response = await http.delete(Uri.parse("${endpoint}lessor/$id"));
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}lessor/$id"));
    }
  }

  @override
  Future<List<LessorModel>> getData() async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}lessors"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
        return body.map((data) => LessorModel.fromJson(data)).toList();
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}lessor}"));
    }
  }

  @override
  Future<LessorModel> getDataById(int id) async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}lessor/$id"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return LessorModel.fromJson(body);
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}lessors"));
    }
  }

  @override
  void postData(LessorModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}lessor"),
          body: data.toJsonWithoutId(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}lessor"));
    }
  }

  @override
  void updateData(LessorModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}lessor"),
          body: data.toJson(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}lessor"));
    }
  }
}
