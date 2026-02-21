import 'package:dio/dio.dart';
import '../models/payment_method_model.dart';
import '../models/transaction_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/shared_prefs_util.dart';

class PaymentRepository {
  final Dio _dio = Dio();

  Future<Options> _getOptions() async {
    final String? token = await SharedPrefsUtil.getToken();
    print("DEBUG: Using Token -> $token");
    return Options(
      headers: {
        'apiKey': ApiConstants.apiKey,
        'Authorization': 'Bearer ${token ?? ""}',
      },
    );
  }

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final options = await _getOptions();
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/payment-methods', 
        options: options,
      );

      print("DEBUG: Response Payment Methods -> ${response.data}");

      if (response.data['data'] != null) {
        final List data = response.data['data'];
        return data.map((json) => PaymentMethodModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print("DEBUG: Error Get Payment Methods -> ${e.response?.data}");
      throw Exception(e.response?.data['message'] ?? 'Gagal memuat bank');
    }
  }

  Future<TransactionModel> createTransaction({
    required String cartId,
    required String paymentMethodId,
  }) async {
    try {
      final options = await _getOptions();
      print("DEBUG: Posting Transaction -> cartId: $cartId, method: $paymentMethodId");

      final response = await _dio.post(
        '${ApiConstants.baseUrl}/generate-payment-methods', 
        data: {
          'cartId': cartId,
          'paymentMethodId': paymentMethodId,
        },
        options: options,
      );

      print("DEBUG: Response Generate Transaction -> ${response.data}");

      if (response.data['data'] != null) {
        return TransactionModel.fromJson(response.data['data']);
      }
      throw Exception('Data transaksi kosong');
    } on DioException catch (e) {
      print("DEBUG: Error Create Transaction -> ${e.response?.data}");
      throw Exception(e.response?.data['message'] ?? 'Pembayaran gagal');
    }
  }
}