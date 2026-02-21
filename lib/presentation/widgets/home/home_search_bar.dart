import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../pages/search/search_page.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.search_rounded, color: Color(0xFF0052CC), size: 22),
            const SizedBox(width: 12),
            Text(
              "Cari aktivitas seru...",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey.shade500,
              ),
            ),
            const Spacer(),
            Icon(Icons.tune_rounded, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }
}