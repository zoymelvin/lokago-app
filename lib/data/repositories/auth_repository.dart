import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lokago/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/api_constants.dart';

class AuthRepository {
  final Dio _dio;
  AuthRepository(this._dio);

  Future<Response> register({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    return await _dio.post(ApiConstants.register, data: {
      "email": email,
      "password": password,
      "passwordRepeat": password,
      "role": "user",
      "name": name,
      "phoneNumber": phoneNumber,
      "profilePictureUrl": "https://i.pravatar.cc/150",
    });
  }

  Future<Response> login(String email, String password) async {
    return await _dio.post(ApiConstants.login, data: {
      "email": email,
      "password": password,
    });
  }

  Future<UserModel> getLoggedUser() async {
    try {
      final response = await _dio.get(ApiConstants.user);
      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile({
  required String name,
  required String email,
  required String phoneNumber,
  required String profilePictureUrl,
}) async {
  try {
    await _dio.post(
      ApiConstants.updateProfile, // Pastikan ini ada di api_constants.dart
      data: {
        "name": name,
        "email": email,
        "phoneNumber": phoneNumber,
        "profilePictureUrl": profilePictureUrl,
      },
    );
  } catch (e) {
    rethrow;
  }
}

Future<String> uploadImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      final response = await _dio.post(ApiConstants.uploadImage, data: formData);
      return response.data['url']; // Mengambil URL hasil upload
    } catch (e) {
      rethrow;
    }
  }

Future<void> updatePassword({
  required String oldPassword,
  required String newPassword,
  required String confirmNewPassword,
}) async {
  try {
    await _dio.post(
      ApiConstants.updatePassword, // Pastikan 'update-password' sudah ada di ApiConstants
      data: {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "confirmNewPassword": confirmNewPassword,
      },
    );
  } catch (e) {
    rethrow;
  }
}

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}