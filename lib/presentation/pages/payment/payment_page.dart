import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokago/presentation/widgets/payment/payment_contact_detail.dart';
import 'package:lokago/presentation/widgets/payment/payment_cost_summary.dart';
import 'package:lokago/presentation/widgets/payment/payment_methods_list.dart';
import 'package:lokago/presentation/widgets/payment/payment_order_summary.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../blocs/payment_bloc/payment_bloc.dart';
import '../../blocs/payment_bloc/payment_event.dart';
import '../../blocs/payment_bloc/payment_state.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_bloc/user_event.dart';
import 'transaction_detail_page.dart';

class PaymentPage extends StatefulWidget {
  final CartItemModel cartItem;
  const PaymentPage({super.key, required this.cartItem});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedMethodId;
  final int serviceFee = 3000;

  @override
  void initState() {
    super.initState();
    context.read<PaymentBloc>().add(FetchPaymentMethods());
    context.read<UserBloc>().add(GetUserProfile());
  }

  void _showSuccessDialog(BuildContext context, TransactionSuccess state) {
    final paymentState = context.read<PaymentBloc>().state;
    String methodName = "Transfer Bank";
    String methodImage = "";

    if (paymentState is PaymentMethodsSuccess) {
      final method = paymentState.methods.firstWhere(
        (m) => m.id == selectedMethodId,
        orElse: () => paymentState.methods.first,
      );
      methodName = method.name;
      methodImage = method.imageUrl;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green,
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.check_rounded,
                        color: Colors.white, size: 50),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text("Pembayaran Berhasil!",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(
                "Pembayaran Anda telah kami terima secara instan. Silakan cek e-tiket Anda pada detail transaksi di bawah ini.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    final successTransaction = TransactionModel(
                      id: state.transaction.id,
                      invoiceId: state.transaction.invoiceId,
                      status: "SUCCESS", 
                      totalAmount: state.transaction.totalAmount,
                      paymentInstruction: state.transaction.paymentInstruction,
                      transactionItems: state.transaction.transactionItems,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransactionDetailPage(
                          transaction: successTransaction,
                          cartItem: widget.cartItem,
                          paymentMethodName: methodName,
                          paymentMethodImage: methodImage,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text("Lihat Detail Pembayaran",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int subtotal =
        widget.cartItem.activity.price * widget.cartItem.quantity;
    final int total = subtotal + serviceFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text("Checkout",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
        child: Column(
          children: [
            PaymentOrderSummary(cartItem: widget.cartItem, subtotal: subtotal),
            const SizedBox(height: 16),
            const PaymentContactDetail(),
            const SizedBox(height: 16),
            PaymentMethodsList(
              selectedMethodId: selectedMethodId,
              onMethodSelected: (id) => setState(() => selectedMethodId = id),
            ),
            const SizedBox(height: 16),
            PaymentCostSummary(
                subtotal: subtotal, serviceFee: serviceFee, total: total),
          ],
        ),
      ),
      bottomSheet: _buildBottomAction(),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is TransactionSuccess) _showSuccessDialog(context, state);
          if (state is PaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: ElevatedButton(
          onPressed: selectedMethodId == null
              ? null
              : () => context.read<PaymentBloc>().add(
                    CreateTransaction(
                      cartId: widget.cartItem.id,
                      paymentMethodId: selectedMethodId!,
                    ),
                  ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
          ),
          child: context.watch<PaymentBloc>().state is PaymentLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2),
                )
              : const Text("Bayar Sekarang",
                  style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}