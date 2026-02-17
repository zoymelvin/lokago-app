import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0052CC);
    const textColor = Color(0xFF002D67);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text(
          "Pusat Bantuan",
          style: GoogleFonts.poppins(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: textColor, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        children: [
          Text(
            "Pertanyaan Umum (FAQ)",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Temukan jawaban cepat untuk kendala Anda",
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 25),

          _buildHelpItem(primaryColor, 1, "Bagaimana cara melakukan reservasi?", 
            "Buka halaman beranda, pilih aktivitas yang Anda inginkan, klik 'Tambah ke Keranjang' atau 'Pesan Sekarang', lalu ikuti instruksi pembayaran."),
          
          _buildHelpItem(primaryColor, 2, "Metode pembayaran apa saja yang tersedia?", 
            "Kami menerima berbagai metode pembayaran mulai dari Transfer Bank (VA), Kartu Kredit, hingga E-Wallet seperti GoPay dan OVO."),
          
          _buildHelpItem(primaryColor, 3, "Apakah saya bisa membatalkan pesanan?", 
            "Ya, pembatalan dapat dilakukan melalui menu 'Pesanan'. Harap perhatikan kebijakan pembatalan yang berlaku pada setiap detail aktivitas."),
          
          _buildHelpItem(primaryColor, 4, "Bagaimana cara mendapatkan e-voucher saya?", 
            "Setelah pembayaran dikonfirmasi, e-voucher akan otomatis muncul di menu 'Pesanan' dan juga dikirimkan ke email terdaftar Anda."),
          
          _buildHelpItem(primaryColor, 5, "Mengapa pembayaran saya gagal?", 
            "Pastikan saldo Anda mencukupi dan koneksi internet stabil. Jika masalah berlanjut, silakan cek batas limit transaksi pada bank Anda."),

          _buildHelpItem(primaryColor, 6, "Berapa lama proses konfirmasi pembayaran?", 
            "Untuk metode pembayaran otomatis (VA/E-Wallet), konfirmasi instan. Untuk transfer manual, proses verifikasi membutuhkan waktu maksimal 1x24 jam."),

          _buildHelpItem(primaryColor, 7, "Apakah harga sudah termasuk pajak?", 
            "Ya, seluruh harga yang tertera di LokaGo sudah termasuk pajak dan biaya layanan tambahan lainnya."),

          _buildHelpItem(primaryColor, 8, "Bagaimana cara mengganti jadwal perjalanan?", 
            "Reschedule tergantung pada ketersediaan dan kebijakan masing-masing vendor. Silakan hubungi kami via email untuk bantuan lebih lanjut."),

          _buildHelpItem(primaryColor, 9, "Data apa saja yang diperlukan saat check-in?", 
            "Anda hanya perlu menunjukkan e-voucher yang ada di aplikasi LokaGo beserta identitas diri (KTP/Passport) yang sah."),

          _buildHelpItem(primaryColor, 10, "Bagaimana jika vendor membatalkan aktivitas?", 
            "Jika aktivitas dibatalkan oleh pihak vendor, dana Anda akan dikembalikan 100% ke saldo LokaGo atau rekening asal Anda."),

          _buildHelpItem(primaryColor, 11, "Apakah anak-anak perlu membayar tiket penuh?", 
            "Kebijakan harga anak-anak berbeda di setiap aktivitas. Detail ini bisa Anda lihat pada bagian 'Informasi Penting' di halaman detail aktivitas."),

          _buildHelpItem(primaryColor, 12, "Bagaimana cara menggunakan kode promo?", 
            "Masukkan kode promo di kolom yang tersedia pada halaman checkout sebelum Anda melakukan klik pada tombol bayar."),

          const SizedBox(height: 120),
        ],
      ),
    );
  }

  Widget _buildHelpItem(Color primaryColor, int number, String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          leading: Text(
            "$number.",
            style: GoogleFonts.poppins(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          title: Text(
            question,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF002D67),
            ),
          ),
          iconColor: primaryColor,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(52, 0, 20, 20),
              child: Text(
                answer,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}