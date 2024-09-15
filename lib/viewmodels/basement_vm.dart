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
    final header = await Endpoint.header;
    try {
      final response = await http.delete(Uri.parse("${endpoint}asset/$id"));
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}asset/$id"));
    }
  }

  @override
  Future<List<BasementModel>> getData() async {
    final header = await Endpoint.header;
    try {
      final response = await http.get(
          Uri.parse("${endpoint}asset/building/basements"),
          headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
        return body.map((data) => BasementModel.fromJson(data)).toList();
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}asset/building/basements}"));
    }
  }

  @override
  void postData(BasementModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(
          Uri.parse("${endpoint}asset/building/basement"),
          body: data.toJsonWithoutId(),
          headers: header);
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}asset/building/basment"));
    }
  }

  @override
  void updateData(BasementModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}renter"),
          body: data.toJson(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}renter"));
    }
  }

  @override
  Future<BasementModel> getDataById(int id) {
    // TODO: implement getDataById
    throw UnimplementedError();
  }
}
