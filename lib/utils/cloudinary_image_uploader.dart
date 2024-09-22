import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';

class CloudinaryImageUploader {
  final cloud_name = "ddh0ufapm";
  final preset = "kiykok4n";

  Future<String> uploadImages(File file) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloud_name/upload');
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = preset
      ..files.add(await http.MultipartFile.fromPath('file', file.path));
    final response = await request.send();
    print(response);
    if (response.statusCode == 200) {
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      print(jsonMap['url'] as String);
      return jsonMap['url'] as String;
    } else {
      throw FileNotFoundException(file.path);
    }
  }

  Future<File?> pickAndUploadImage(
      {ImageSource source = ImageSource.gallery}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image == null) return null;

      File imageFile = File(image.path);
      print(imageFile.path);
      return imageFile;
    } catch (e) {
      //debugPrint('Error picking or uploading image: $e');
      return null;
    }
  }
}
