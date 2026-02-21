import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokago/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:lokago/presentation/blocs/cart_bloc/cart_event.dart';
import '../../../../data/models/cart_item_model.dart';
import '../../../../core/utils/formatter.dart';
import '../../pages/payment/payment_page.dart'; 

class CartItemCard extends StatelessWidget {
  final CartItemModel item;
  const CartItemCard({super.key, required this.item});

  void _handleUpdateQty(BuildContext context, int currentQty, bool isIncrement) async {
    final cartBloc = context.read<CartBloc>();

    if (isIncrement) {
      cartBloc.add(AddToCart(activityId: item.activity.id, quantity: 1));
    } else {
      if (currentQty <= 1) return;

      cartBloc.add(DeleteFromCart(item.id));

      await Future.delayed(const Duration(milliseconds: 800));

      int targetQty = currentQty - 1;
      for (int i = 0; i < targetQty; i++) {
        cartBloc.add(AddToCart(activityId: item.activity.id, quantity: 1));
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const bluePrimary = Color(0xFF2563EB);
    final int itemTotal = item.activity.price * item.quantity;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    item.activity.imageUrls.isNotEmpty ? item.activity.imageUrls[0] : '',
                    width: 80, height: 80, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 80, height: 80, color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.activity.title,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.read<CartBloc>().add(DeleteFromCart(item.id)),
                            child: const Icon(Icons.close_rounded, color: Colors.red, size: 18),
                          ),
                        ],
                      ),
                      Text(item.activity.city, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 11)),
                      const SizedBox(height: 8),
                      Text(
                        "${item.activity.price.toRupiah()} / tiket",
                        style: GoogleFonts.poppins(color: Colors.black87, fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.withOpacity(0.1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      _buildSmallQtyBtn(
                        icon: Icons.remove,
                        onTap: () => _handleUpdateQty(context, item.quantity, false),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "${item.quantity}",
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      _buildSmallQtyBtn(
                        icon: Icons.add,
                        onTap: () => _handleUpdateQty(context, item.quantity, true),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      itemTotal.toRupiah(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 15, color: bluePrimary),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentPage(cartItem: item),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bluePrimary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(
                        "Bayar",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, size: 16, color: Colors.black87),
      ),
    );
  }
}