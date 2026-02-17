import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text("Kebijakan Privasi", 
          style: GoogleFonts.poppins(color: const Color(0xFF002D67), fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Privasi Anda Penting Bagi Kami", 
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0052CC))),
            const SizedBox(height: 15),
            _buildTextSection("1. Pengumpulan Informasi", 
              "LokaGo mengumpulkan data pribadi seperti nama, email, dan nomor telepon saat Anda mendaftar untuk memberikan layanan perjalanan yang personal."),
            _buildTextSection("2. Penggunaan Data", 
              "Data Anda digunakan untuk proses pemesanan tiket, konfirmasi transaksi, dan memberikan rekomendasi destinasi wisata yang sesuai dengan minat Anda."),
            _buildTextSection("3. Keamanan Data", 
              "Kami menggunakan enkripsi tingkat tinggi untuk memastikan data Anda aman dan tidak disalahgunakan oleh pihak yang tidak bertanggung jawab."),
            const SizedBox(height: 20),
            Text("Terakhir diperbarui: 18 Februari 2026", 
              style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(content, style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87, height: 1.6)),
        ],
      ),
    );
  }
}