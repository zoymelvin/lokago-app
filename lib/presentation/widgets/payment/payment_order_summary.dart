import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../core/utils/formatter.dart';

class PaymentOrderSummary extends StatelessWidget {
  final CartItemModel cartItem;
  final int subtotal;

  const PaymentOrderSummary({super.key, required this.cartItem, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(cartItem.activity.imageUrls[0], width: 70, height: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.activity.title,
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                    maxLines: 1),
                Text("${cartItem.quantity} Tiket",
                    style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                Text(subtotal.toRupiah(),
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}