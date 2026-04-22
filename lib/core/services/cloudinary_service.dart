import 'dart:typed_data';

import 'package:dio/dio.dart';

class CloudinaryService {
  final Dio _dio = Dio();

  final String cloudName = 'dreuicigr';
  final String uploadPreset = 'doctor_app_upload';
  Future<String> uploadImage(Uint8List imageBytes) async {
    final url = 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';
    final formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(imageBytes, filename: 'doctor.jpg'),
      'upload_preset': uploadPreset,
    });
    final response = await _dio.post(url, data: formData);
    if (response.statusCode == 200) {
      return response.data['secure_url'];
    } else {
      throw Exception('Failed to upload image');
    }
  }
}
