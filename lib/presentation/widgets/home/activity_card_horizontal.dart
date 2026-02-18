import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/activity_model.dart';
import '../../../core/utils/formatter.dart';

class ActivityCardHorizontal extends StatelessWidget {
  final ActivityModel activity;

  const ActivityCardHorizontal({super.key, required this.activity});

  @override
  Widget build(BuildContext context) {
    bool hasImage = activity.imageUrls.isNotEmpty && activity.imageUrls[0].isNotEmpty;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 130,
              height: 100,
              child: hasImage
                  ? Image.network(
                      activity.imageUrls[0],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
                    )
                  : _buildPlaceholder(),
            ),
          ),
          const SizedBox(width: 12),

          // BAGIAN INFORMASI
          Expanded(
            child: SizedBox(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: const Color(0xFF1A1A1A),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 12, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            activity.city,
                            style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // 3. REVIEWS & BINTANG
                  Row(
                    children: [
                      _buildRatingStars(activity.rating),
                      const SizedBox(width: 8),
                      const Icon(Icons.person, size: 12, color: Colors.grey),
                      const SizedBox(width: 2),
                      Text(
                        "(${activity.totalReviews})",
                        style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (activity.priceDiscount > 0)
                            Text(
                              (activity.price + activity.priceDiscount).toRupiah(),
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          // Harga Utama
                          Text(
                            activity.price.toRupiah(),
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0052CC),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingStars(double rating) {
    int fullStars = rating.floor();
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          Icons.star_rounded,
          size: 14,
          color: index < fullStars ? Colors.amber : Colors.grey[300],
        );
      }),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[100],
      child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
    );
  }
}