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
    await http.delete(Uri.parse("${endpoint}renter/$id"), headers: header);
  }

  @override
  Future<List<RenterModel>> getData() async {
    final header = await Endpoint.header;

    final response =
        await http.get(Uri.parse("${endpoint}renters"), headers: header);

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body
          .map((data) => RenterModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } else {
      throw HttpException("HTTP ${response.statusCode}: ${response.body}",
          uri: Uri.parse("${endpoint}renters"));
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
        throw HttpException("HTTP ${response.statusCode}: ${response.body}",
            uri: Uri.parse("${endpoint}renter/{$id}"));
      }
    } catch (e) {
      print("Exception caught: $e");
      if (e is FormatException) {
        throw HttpException("Invalid JSON response",
            uri: Uri.parse("${endpoint}renter/$id"));
      } else if (e is HttpException) {
        rethrow;
      } else {
        throw HttpException("Network error: ${e.toString()}",
            uri: Uri.parse("${endpoint}renter/$id"));
      }
    }
  }

  @override
  void postData(RenterModel data) async {
    final header = await Endpoint.header;

    final response = await http.post(Uri.parse("${endpoint}renter"),
        body: jsonEncode(data.toJsonWithoutId()), headers: header);
  }

  @override
  void updateData(RenterModel data) async {
    final header = await Endpoint.header;

    final response = await http.post(Uri.parse("${endpoint}renter"),
        body: jsonEncode(data.toJsonWithoutId()), headers: header);
  }
}
