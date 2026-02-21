import 'package:dio/dio.dart';
import '../models/payment_method_model.dart';
import '../models/transaction_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/utils/shared_prefs_util.dart';

class PaymentRepository {
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

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    try {
      final options = await _getOptions();
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/payment-methods',
        options: options,
      );

      if (response.data != null && response.data['data'] != null) {
        final List data = response.data['data'];
        return data.map((json) => PaymentMethodModel.fromJson(json)).toList();
      }
      return [];
    } on DioException catch (e) {
      print("EROR FETCH BANK: ${e.response?.data}");
      throw Exception(e.response?.data['message'] ?? 'Gagal memuat metode pembayaran');
    }
  }


Future<List<TransactionModel>> getTransactionHistory() async {
    try {
      final options = await _getOptions();
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/my-transactions', 
        options: options,
      );

      print("DEBUG ALL TRANSACTIONS RESPONSE: ${response.data}");

      if (response.data != null) {
        final dynamic rawData = response.data['data'] ?? response.data;
        
        if (rawData is List) {
          return rawData.map((json) => TransactionModel.fromJson(json)).toList();
        }
      }
      return [];
    } on DioException catch (e) {
      print("DIO ERROR HISTORY: ${e.response?.data}");
      throw Exception(e.response?.data['message'] ?? 'Gagal memuat riwayat');
    } catch (e) {
      print("GENERAL ERROR HISTORY: $e");
      throw Exception('Kesalahan saat memproses data transaksi');
    }
  }
  Future<TransactionModel> createTransaction({
    required String cartId,
    required String paymentMethodId,
  }) async {
    try {
      final options = await _getOptions();
      
      print("DEBUG SENDING: cartIds: [$cartId], paymentMethodId: $paymentMethodId");

      final response = await _dio.post(
        '${ApiConstants.baseUrl}/create-transaction',
        data: {
          'cartIds': [cartId], 
          'paymentMethodId': paymentMethodId,
        },
        options: options,
      );

      if (response.data['code'] == 200 || response.data['status'] == 'OK') {
        if (response.data['data'] != null) {
          return TransactionModel.fromJson(response.data['data']);
        } else {
         return TransactionModel(
  id: cartId,
  invoiceId: "INV-${DateTime.now().millisecondsSinceEpoch}",
  status: "PENDING",
  totalAmount: 0,
  paymentInstruction: "Pesanan berhasil dibuat. Silakan cek riwayat.",
  transactionItems: const [],
);
        }
      }
      throw Exception('Gagal memproses transaksi');
    } on DioException catch (e) {
      print("EROR DETAIL DARI SERVER: ${e.response?.data}");
      throw Exception(e.response?.data['message'] ?? 'Proses pembayaran gagal');
    }
  }
}