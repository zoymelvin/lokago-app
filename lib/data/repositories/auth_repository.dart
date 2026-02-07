import 'package:dio/dio.dart';
import '../api/dio_client.dart';
import '../../core/constants/api_constants.dart';

class AuthRepository {
  final Dio _dio = DioClient().dio;
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
}