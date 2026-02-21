import 'package:flutter/material.dart';
import '../../../core/utils/formatter.dart';

class PaymentCostSummary extends StatelessWidget {
  final int subtotal;
  final int serviceFee;
  final int total;

  const PaymentCostSummary({super.key, required this.subtotal, required this.serviceFee, required this.total});

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
      child: Column(children: [
        _rowCost("Harga Tiket", subtotal.toRupiah()),
        const SizedBox(height: 8),
        _rowCost("Biaya Layanan", serviceFee.toRupiah()),
        const Divider(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text("Total Bayar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(total.toRupiah(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue)),
        ]),
      ]),
    );
  }

  Widget _rowCost(String l, String v) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(l, style: const TextStyle(color: Colors.grey)),
        Text(v)
      ]);
}