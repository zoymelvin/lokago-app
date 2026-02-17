import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';

class HomeRepository {
  final Dio _dio;

  HomeRepository(this._dio);

  Future<Response> getBanners() async => await _dio.get(ApiConstants.banners);
  
  Future<Response> getCategories() async => await _dio.get(ApiConstants.categories);
  
  Future<Response> getActivities() async => await _dio.get(ApiConstants.activities);
}