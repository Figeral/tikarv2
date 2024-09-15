import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:tikar/models/rent_model.dart';
import 'package:tikar/viewmodels/base_vm.dart';
import 'package:tikar/viewmodels/endpoint.dart';

class RentVM extends BaseVM<RentModel> {
  final endpoint = Endpoint.api();
  @override
  void deleteData(int id) async {
    final header = await Endpoint.header;
    try {
      final response = await http.delete(Uri.parse("${endpoint}rent/$id"));
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}renter/$id"));
    }
  }

  @override
  Future<List<RentModel>> getData() async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}rents"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
        return body.map((data) => RentModel.fromJson(data)).toList();
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}rent}"));
    }
  }

  @override
  Future<RentModel> getDataById(int id) async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}rent/$id"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return RentModel.fromJson(body);
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}rent"));
    }
  }

  @override
  void postData(RentModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}rent"),
          body: data.toJsonWithoutId(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}rent"));
    }
  }

  @override
  void updateData(RentModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}rent"),
          body: data.toJson(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}rent"));
    }
  }
}
