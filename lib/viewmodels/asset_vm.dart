import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:tikar/models/asset_model.dart';
import 'package:tikar/viewmodels/base_vm.dart';
import 'package:tikar/viewmodels/endpoint.dart';

class AssetVM extends BaseVM<AssetModel> {
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
  Future<List<AssetModel>> getData() async {
    final header = await Endpoint.header;
    try {
      final response = await http.get(Uri.parse("${endpoint}assets/parent"),
          headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
        return body.map((data) => AssetModel.fromJson(data)).toList();
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}assets/parent}"));
    }
  }

  Future<List<AssetModel>> getDataBuilding() async {
    final header = await Endpoint.header;
    try {
      final response = await http.get(Uri.parse("${endpoint}assets/buildings"),
          headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
        return body.map((data) => AssetModel.fromJson(data)).toList();
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}assets/buildings}"));
    }
  }

  Future<List<AssetModel>> getDataResidence() async {
    final header = await Endpoint.header;
    try {
      final response = await http.get(Uri.parse("${endpoint}assets/residences"),
          headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
        return body.map((data) => AssetModel.fromJson(data)).toList();
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}assets/residences}"));
    }
  }

  @override
  Future<AssetModel> getDataById(int id) async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}asset/$id"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return AssetModel.fromJson(body);
      } else {
        throw Exception("error occurred ${jsonDecode(response.body)}");
      }
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}asset/$id"));
    }
  }

  @override
  void postData(AssetModel data) async {
    // TODO: implement getDataById
    throw UnimplementedError();
  }

  void postDataBuilding(AssetModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}asset/building"),
          body: data.toJsonWithoutId(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}asset/building"));
    }
  }

  void postDataResidence(AssetModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}asset/residence"),
          body: data.toJsonWithoutId(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(),
          uri: Uri.parse("${endpoint}asset/residence"));
    }
  }

  @override
  void updateData(AssetModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}renter"),
          body: data.toJson(), headers: header);
    } catch (e) {
      throw HttpException(e.toString(), uri: Uri.parse("${endpoint}renter"));
    }
  }
}
