import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../data/models/activity_model.dart';

class ActivityDetailInfo extends StatefulWidget {
  final ActivityModel activity;
  const ActivityDetailInfo({super.key, required this.activity});

  @override
  State<ActivityDetailInfo> createState() => _ActivityDetailInfoState();
}

class _ActivityDetailInfoState extends State<ActivityDetailInfo> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final act = widget.activity;
    final currency = NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0);
    final int finalPrice = act.price;
    final int discountAmount = act.priceDiscount;
    final int originalPrice = finalPrice + discountAmount;
    final bool hasDiscount = discountAmount > 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                act.title,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => setState(() => isBookmarked = !isBookmarked),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isBookmarked ? const Color(0xFF2563EB) : Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    )
                  ],
                ),
                
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 6),
        
        Row(
          children: [
            const Icon(Icons.star_rounded, color: Colors.orange, size: 20),
            const SizedBox(width: 4),
            Text(
              "${act.rating}",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 10,
              backgroundColor: Color(0xFFE5E7EB),
              child: Icon(Icons.person, size: 12, color: Colors.grey),
            ),
            const SizedBox(width: 6),
            Text(
              "${act.totalReviews} Review",
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
        
        const SizedBox(height: 15),
        
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F7FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                hasDiscount ? "Promo Terbatas!" : "Harga Tiket",
                style: const TextStyle(
                  color: Color(0xFF1E40AF),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    currency.format(finalPrice),
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (hasDiscount)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        currency.format(originalPrice),
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                ],
              ),
              if (hasDiscount)
                Text(
                  "Hemat ${currency.format(discountAmount)}",
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}