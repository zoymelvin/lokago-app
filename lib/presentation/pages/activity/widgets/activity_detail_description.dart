import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../data/models/activity_model.dart';

class ActivityDetailDescription extends StatelessWidget {
  final ActivityModel activity;
  const ActivityDetailDescription({super.key, required this.activity});

  String _cleanHtml(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Deskripsi", 
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(
          activity.description,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
        const SizedBox(height: 25),
        Text("Fasilitas", 
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: activity.facilities.split(',').map((f) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle_rounded, size: 14, color: Colors.green),
                  const SizedBox(width: 6),
                  Text(
                    _cleanHtml(f),
                    style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[800]),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}