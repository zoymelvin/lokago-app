import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/activity_model.dart';
import '../../../blocs/cart_bloc/cart_bloc.dart';
import '../../../blocs/cart_bloc/cart_event.dart';
import '../../../../core/utils/formatter.dart';

class AddToCartBottomSheet extends StatefulWidget {
  final ActivityModel activity;
  const AddToCartBottomSheet({super.key, required this.activity});

  @override
  State<AddToCartBottomSheet> createState() => _AddToCartBottomSheetState();
}

class _AddToCartBottomSheetState extends State<AddToCartBottomSheet> {
  int quantity = 1;
  bool isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    final int totalPrice = widget.activity.price * quantity;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36, height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            "Pilih Jumlah Tiket",
            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.activity.imageUrls[0],
                  width: 72, height: 72, fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.activity.title,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                      maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.activity.price.toRupiah(),
                      style: GoogleFonts.poppins(color: const Color(0xFF2563EB), fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    _buildQtyButton(
                      icon: Icons.remove_rounded,
                      onTap: () { if (quantity > 1) setState(() => quantity--); },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text("$quantity", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    _buildQtyButton(
                      icon: Icons.add_rounded,
                      onTap: () => setState(() => quantity++),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 24), child: Divider(height: 1)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Pembayaran", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                  Text(totalPrice.toRupiah(), style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF2563EB))),
                ],
              ),
              ElevatedButton(
                onPressed: isSubmitting ? null : () async {
                  setState(() => isSubmitting = true);

                  for (int i = 0; i < quantity; i++) {
                    context.read<CartBloc>().add(
                      AddToCart(
                        activityId: widget.activity.id,
                        quantity: 1,
                      ),
                    );
                    await Future.delayed(const Duration(milliseconds: 200));
                  }

                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Berhasil ditambahkan ke keranjang")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: isSubmitting 
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text("Konfirmasi", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQtyButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(padding: const EdgeInsets.all(8), child: Icon(icon, size: 20)),
    );
  }
}