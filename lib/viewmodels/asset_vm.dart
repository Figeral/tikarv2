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

    final response =
        await http.delete(Uri.parse("${endpoint}asset/$id"), headers: header);
  }

  @override
  Future<List<AssetModel>> getData() async {
    final header = await Endpoint.header;

    final response =
        await http.get(Uri.parse("${endpoint}assets/parent"), headers: header);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
      return body.map((data) => AssetModel.fromJson(data)).toList();
    } else {
      throw HttpException("HTTP ${response.statusCode}: ${response.body}",
          uri: Uri.parse("${endpoint}assets/parent"));
    }
  }

  Future<List<AssetModel>> getDataBuilding() async {
    final header = await Endpoint.header;

    final response = await http.get(Uri.parse("${endpoint}assets/buildings"),
        headers: header);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body) as List<Map<String, dynamic>>;
      return body.map((data) => AssetModel.fromJson(data)).toList();
    } else {
      throw HttpException("HTTP ${response.statusCode}: ${response.body}",
          uri: Uri.parse("${endpoint}assets/buildings"));
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
        throw HttpException("HTTP ${response.statusCode}: ${response.body}",
            uri: Uri.parse("${endpoint}assets/residences"));
      }
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}assets/residences"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}assets/residences"));
      }
    }
  }

  // @override
  // Future<AssetModel> getDataById(int id) async {
  //   final header = await Endpoint.header;
  //   try {
  //     final response =
  //         await http.get(Uri.parse("${endpoint}asset/$id"), headers: header);
  //     if (response.statusCode == 200) {
  //       final body = jsonDecode(response.body) as Map<String, dynamic>;
  //       return AssetModel.fromJson(body);
  //     } else {
  //       throw HttpException("HTTP ${response.statusCode}: ${response.body}",
  //           uri: Uri.parse("${endpoint}asset/{$id}"));
  //     }
  //   } catch (e) {
  //     print("Exception caught: $e");
  //     if (e is FormatException) {
  //       throw HttpException("Invalid JSON response",
  //           uri: Uri.parse("${endpoint}asset/$id"));
  //     } else if (e is HttpException) {
  //       rethrow;
  //     } else {
  //       throw HttpException("Network error: ${e.toString()}",
  //           uri: Uri.parse("${endpoint}asset/$id"));
  //     }
  //   }
  // }

  @override
  void postData(AssetModel data) async {
    final header = await Endpoint.header;

    final response = await http.post(Uri.parse("${endpoint}asset"),
        body: jsonEncode(data.toJsonWithoutId()), headers: header);
    print(jsonEncode(data.toJsonWithoutId()));
  }

  void postDataResidence(AssetModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}asset/residence"),
          body: jsonEncode(data.toJsonWithoutId()), headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}asset/residence"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}asset/residence"));
      }
    }
  }

  @override
  void updateData(AssetModel data) async {
    final header = await Endpoint.header;

    final response = await http.post(Uri.parse("${endpoint}asset"),
        body: jsonEncode(data.toJson()), headers: header);
  }

  @override
  Future<AssetModel> getDataById(int id) {
    // TODO: implement getDataById
    throw UnimplementedError();
  }
}
