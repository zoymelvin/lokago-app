import 'package:dio/dio.dart';
import '../models/cart_item_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/shared_prefs_util.dart';

class CartRepository {
  final Dio _dio = Dio();

  Future<Options> _getOptions() async {
    final String? token = await SharedPrefsUtil.getToken();
    return Options(
      headers: {
        'apiKey': ApiConstants.apiKey,
        'Authorization': 'Bearer ${token ?? ""}',
      },
    );
  }

  Future<String> updateCartQty({required String activityId, required int quantity}) async {
    try {
      final options = await _getOptions();
      
      print("SENDING TO SERVER -> Activity: $activityId, New Qty: $quantity");

      final response = await _dio.post(
        ApiConstants.addCart,
        data: {
          'activityId': activityId,
          'quantity': quantity, 
        },
        options: options,
      );
      return response.data['message'] ?? 'Berhasil update';
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Gagal update qty');
    }
  }

  Future<List<CartItemModel>> getCartItems() async {
    try {
      final options = await _getOptions();
      final response = await _dio.get(ApiConstants.carts, options: options);

      if (response.data != null && response.data['data'] != null) {
        final List data = response.data['data'];
        return data.map((json) => CartItemModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      throw Exception('Gagal memuat keranjang');
    }
  }

  Future<String> deleteCartItem(String cartId) async {
    try {
      final options = await _getOptions();
      final response = await _dio.delete(
        '${ApiConstants.baseUrl}/delete-cart/$cartId',
        options: options,
      );
      return response.data['message'] ?? 'Berhasil dihapus';
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Gagal hapus');
    }
  }
}