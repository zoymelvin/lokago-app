import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat datang",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.blueGrey[400],
                ),
              ),
              Text(
                "Traveler",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF002D67),
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 14, color: Colors.redAccent),
                  const SizedBox(width: 4),
                  Text(
                    "Jakarta, Indonesia", 
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          Row(
            children: [
              IconButton(
                onPressed: () {
                },
                icon: const Icon(Icons.mail_outline_rounded, color: Color(0xFF002D67)),
              ),
              const CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF0052CC),
                child: Icon(Icons.person, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}