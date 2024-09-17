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
    try {
      final response =
          await http.delete(Uri.parse("${endpoint}staff/$id"), headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}staff/$id"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}staff/$id"));
      }
    }
  }

  @override
  Future<List<StaffModel>> getData() async {
    final header = await Endpoint.header;
    try {
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
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}staffs"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}staffs"));
      }
    }
  }

  @override
  Future<StaffModel> getDataById(int id) async {
    final header = await Endpoint.header;
    try {
      final response =
          await http.get(Uri.parse("${endpoint}staff/$id"), headers: header);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        return StaffModel.fromJson(body);
      } else {
        throw HttpException("HTTP ${response.statusCode}: ${response.body}",
            uri: Uri.parse("${endpoint}staff/{$id}"));
      }
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}staff/$id"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}staff/$id"));
      }
    }
  }

  @override
  void postData(StaffModel data) async {
    final endpoint = Endpoint.signIn();

    try {
      final response = await http.post(Uri.parse(endpoint),
          body: data.toJsonWithoutId());
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}staff"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}staff"));
      }
    }
  }

  @override
  void updateData(StaffModel data) async {
    final header = await Endpoint.header;
    try {
      final response = await http.post(Uri.parse("${endpoint}staff"),
          body: data.toJson(), headers: header);
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}staff"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}staff"));
      }
    }
  }
}
