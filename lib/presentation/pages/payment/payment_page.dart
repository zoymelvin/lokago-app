import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokago/data/models/cart_item_model.dart';
import 'package:lokago/core/utils/formatter.dart';
import 'package:lokago/presentation/blocs/payment_bloc/payment_bloc.dart';
import 'package:lokago/presentation/blocs/payment_bloc/payment_event.dart';
import 'package:lokago/presentation/blocs/payment_bloc/payment_state.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_state.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_event.dart';

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

  @override
  Widget build(BuildContext context) {
    final int subtotal = widget.cartItem.activity.price * widget.cartItem.quantity;
    final int total = subtotal + serviceFee;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 150),
        child: Column(
          children: [
            _buildOrderSummary(subtotal),
            const SizedBox(height: 16),
            _buildContactDetail(),
            const SizedBox(height: 16),
            _buildPaymentMethods(),
            const SizedBox(height: 16),
            _buildCostSummary(subtotal, total),
          ],
        ),
      ),
      bottomSheet: _buildBottomAction(total),
    );
  }

  Widget _buildOrderSummary(int subtotal) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Ringkasan Aktivitas", style: _sectionTitleStyle()),
          const SizedBox(height: 16),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.cartItem.activity.imageUrls.isNotEmpty 
                      ? widget.cartItem.activity.imageUrls[0] 
                      : '',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 80, height: 80, color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartItem.activity.title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${widget.cartItem.quantity} Tiket",
                      style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtotal.toRupiah(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactDetail() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Detail Pemesan", style: _sectionTitleStyle()),
          const SizedBox(height: 16),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              String userName = "Memuat...";
              String userEmail = "Memuat...";

              if (state is UserSuccess) {
                userName = state.user.name ?? "-";
                userEmail = state.user.email ?? "-";
              }

              return Column(
                children: [
                  _buildInfoTile("Nama", userName), 
                  const SizedBox(height: 12),
                  _buildInfoTile("Email ", userEmail),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 11)),
          Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Metode Pembayaran", style: _sectionTitleStyle()),
          const SizedBox(height: 16),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              if (state is PaymentLoading) {
                return const Center(child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(),
                ));
              } else if (state is PaymentMethodsSuccess) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.methods.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final method = state.methods[index];
                    final isSelected = selectedMethodId == method.id;

                    return GestureDetector(
                      onTap: () => setState(() => selectedMethodId = method.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFEFF6FF) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF2563EB) : Colors.grey.shade200,
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 40,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                method.imageUrl, 
                                fit: BoxFit.contain,
                                errorBuilder: (context, _, __) => const Icon(Icons.account_balance, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                method.name,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            // Custom Radio Button
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF2563EB) : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                      child: Container(
                                        width: 12, height: 12,
                                        decoration: const BoxDecoration(color: Color(0xFF2563EB), shape: BoxShape.circle),
                                      ),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Text("Gagal memuat metode pembayaran");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCostSummary(int subtotal, int total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Rincian Biaya", style: _sectionTitleStyle()),
          const SizedBox(height: 16),
          _costRow("Harga Tiket", subtotal.toRupiah()),
          const SizedBox(height: 8),
          _costRow("Biaya Layanan", serviceFee.toRupiah()),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Bayar", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 15)),
              Text(total.toRupiah(), style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 16, color: const Color(0xFF2563EB))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _costRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13)),
        Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 13)),
      ],
    );
  }

  Widget _buildBottomAction(int total) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BlocListener<PaymentBloc, PaymentState>(
        listener: (context, state) {
          if (state is TransactionSuccess) {
          } else if (state is PaymentError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: ElevatedButton(
          onPressed: selectedMethodId == null
              ? null
              : () {
                  context.read<PaymentBloc>().add(CreateTransaction(
                        cartId: widget.cartItem.id,
                        paymentMethodId: selectedMethodId!,
                      ));
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
            disabledBackgroundColor: Colors.grey.shade300,
          ),
          child: context.watch<PaymentBloc>().state is PaymentLoading
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
              : Text("Bayar Sekarang", style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 16)),
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade100),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4))],
    );
  }

  TextStyle _sectionTitleStyle() {
    return GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.black);
  }
}