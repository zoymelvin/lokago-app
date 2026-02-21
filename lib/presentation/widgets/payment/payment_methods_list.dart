import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/payment_bloc/payment_bloc.dart';
import '../../blocs/payment_bloc/payment_state.dart';

class PaymentMethodsList extends StatelessWidget {
  final String? selectedMethodId;
  final Function(String) onMethodSelected;

  const PaymentMethodsList({super.key, this.selectedMethodId, required this.onMethodSelected});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Metode Pembayaran", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              if (state is PaymentLoading) return const Center(child: CircularProgressIndicator());
              if (state is PaymentMethodsSuccess) {
                return Column(
                  children: state.methods.map((m) {
                    final isSelected = selectedMethodId == m.id;
                    return GestureDetector(
                      onTap: () => onMethodSelected(m.id),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: isSelected ? Colors.blue : Colors.grey[200]!),
                          color: isSelected ? Colors.blue.withOpacity(0.05) : Colors.white,
                        ),
                        child: Row(children: [
                          Image.network(m.imageUrl, width: 50, height: 30, fit: BoxFit.contain, errorBuilder: (_, __, ___) => const Icon(Icons.payment)),
                          const SizedBox(width: 12),
                          Expanded(child: Text(m.name, style: const TextStyle(fontWeight: FontWeight.w500))),
                          if (isSelected) const Icon(Icons.check_circle, color: Colors.blue, size: 20),
                        ]),
                      ),
                    );
                  }).toList(),
                );
              }
              return const Text("Gagal memuat bank");
            },
          ),
        ],
      ),
    );
  }
}