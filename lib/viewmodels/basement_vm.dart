import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:tikar/models/asset_model.dart';
import 'package:tikar/viewmodels/base_vm.dart';
import 'package:tikar/viewmodels/endpoint.dart';

class BasementVm extends BaseVM<BasementModel> {
  final endpoint = Endpoint.api();
  @override
  void deleteData(int id) async {
    // TODO: implement getDataById
    throw UnimplementedError();
  }

  @override
  Future<List<BasementModel>> getData() async {
    final header = await Endpoint.header;

    final response = await http
        .get(Uri.parse("${endpoint}asset/building/basements"), headers: header);
    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body
          .map((data) => BasementModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } else {
      throw HttpException("HTTP ${response.statusCode}: ${response.body}",
          uri: Uri.parse("${endpoint}asset/building/basements"));
    }
  }

  @override
  void postData(BasementModel data) async {
    final header = await Endpoint.header;

    final response = await http.post(
        Uri.parse("${endpoint}asset/building/basement"),
        body: jsonEncode(data.toJsonWithoutId()),
        headers: header);
  }

  @override
  void updateData(BasementModel data) async {
    final header = await Endpoint.header;

    final response = await http.post(
        Uri.parse("${endpoint}asset/building/basement"),
        body: jsonEncode(data.toJson()),
        headers: header);
  }

  @override
  Future<BasementModel> getDataById(int id) {
    // TODO: implement getDataById
    throw UnimplementedError();
  }
}
