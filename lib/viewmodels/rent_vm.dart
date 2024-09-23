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
      final response =
          await http.delete(Uri.parse("${endpoint}rent/$id"), headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}rent/$id"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}rent/$id"));
      }
    }
  }

  @override
  Future<List<RentModel>> getData() async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}rents"), headers: header);
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);

        return body
            .map((data) => RentModel.fromJson(data as Map<String, dynamic>))
            .toList();
      } else {
        throw HttpException("HTTP ${response.statusCode}: ${response.body}",
            uri: Uri.parse("${endpoint}rents"));
      }
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}rents"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}rents"));
      }
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
        throw HttpException("HTTP ${response.statusCode}: ${response.body}",
            uri: Uri.parse("${endpoint}rent/{$id}"));
      }
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}rent/$id"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}rent/$id"));
      }
    }
  }

  @override
  void postData(RentModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}rent"),
          body: jsonEncode(data.toJsonWithoutId()), headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}rent"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}rent"));
      }
    }
  }

  @override
  void updateData(RentModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}rent"),
          body: jsonEncode(data.toJson()), headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}rent"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}rent"));
      }
    }
  }
}
