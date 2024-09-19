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
      final response = await http.delete(Uri.parse("${endpoint}lessor/$id"),
          headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}lessor/$id"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}lessor/$id"));
      }
    }
  }

  @override
  Future<List<LessorModel>> getData() async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}lessors"), headers: header);
      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);

        return body
            .map((data) => LessorModel.fromJson(data as Map<String, dynamic>))
            .toList();
      } else {
        throw HttpException("HTTP ${response.statusCode}: ${response.body}",
            uri: Uri.parse("${endpoint}lessors"));
      }
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}lessors"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}lessors"));
      }
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
        print(body);
        return LessorModel.fromJson(body);
      } else {
        throw HttpException("HTTP ${response.statusCode}: ${response.body}",
            uri: Uri.parse("${endpoint}lessor/{$id}"));
      }
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}lessor/$id"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}lessor/$id"));
      }
    }
  }

  @override
  void postData(LessorModel data) async {
    final header = await Endpoint.header;
    try {
      print(data.toJson());
      final response = await http.post(Uri.parse("${endpoint}lessor"),
          body: jsonEncode(data.toJsonWithoutId()), headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}lessor"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}lessor"));
      }
    }
  }

  @override
  void updateData(LessorModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}lessor"),
          body: jsonEncode(data.toJson()), headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}lessor"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}lessor"));
      }
    }
  }
}
