import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:tikar/viewmodels/base_vm.dart';
import 'package:tikar/models/renter_model.dart';
import 'package:tikar/viewmodels/endpoint.dart';

class RenterVM extends BaseVM<RenterModel> {
  final endpoint = Endpoint.api();

  @override
  void deleteData(int id) async {
    final header = await Endpoint.header;
    try {
      final response = await http.delete(Uri.parse("${endpoint}renter/$id"));
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}renter/$id"));
    }
  }

  @override
  Future<List<RenterModel>> getData() async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}renters"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
        return body.map((data) => RenterModel.fromJson(data)).toList();
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}renter}"));
    }
  }

  @override
  Future<RenterModel> getDataById(int id) async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}renter/$id"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return RenterModel.fromJson(body);
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}renter"));
    }
  }

  @override
  void postData(RenterModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}renter"),
          body: data.toJsonWithoutId(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}renter"));
    }
  }

  @override
  void updateData(RenterModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}renter"),
          body: data.toJson(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}renter"));
    }
  }
}
