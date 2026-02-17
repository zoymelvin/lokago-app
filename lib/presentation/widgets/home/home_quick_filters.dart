import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeQuickFilters extends StatelessWidget {
  const HomeQuickFilters({super.key});

  @override
  Widget build(BuildContext context) {
    final filters = [
      {'l': 'Populer', 'i': Icons.star_rounded},
      {'l': 'Termurah', 'i': Icons.trending_down_rounded},
      {'l': 'Eksklusif', 'i': Icons.diamond_rounded},
    ];
    
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4)],
            ),
            child: Row(
              children: [
                Icon(filters[index]['i'] as IconData, color: const Color(0xFF0052CC), size: 16),
                const SizedBox(width: 6),
                Text(
                  filters[index]['l'] as String, 
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500)
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}