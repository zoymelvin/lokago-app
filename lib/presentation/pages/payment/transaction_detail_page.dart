import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/models/cart_item_model.dart';
import '../../../core/utils/formatter.dart';

class TransactionDetailPage extends StatefulWidget {
  final TransactionModel transaction;
  final CartItemModel cartItem;
  final String paymentMethodName;
  final String paymentMethodImage;

  const TransactionDetailPage({
    super.key,
    required this.transaction,
    required this.cartItem,
    required this.paymentMethodName,
    required this.paymentMethodImage,
  });

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  @override
  void initState() {
    super.initState();
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    final int subtotal = widget.cartItem.activity.price * widget.cartItem.quantity;
    final int total = subtotal + 3000;
    final String formattedDate = DateFormat('dd MMMM yyyy, HH:mm').format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildPaperTicket(subtotal, total),
              const SizedBox(height: 20),
              _buildTransactionInfo(formattedDate),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    "Lihat Tiket Saya",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 40),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "Transaksi Berhasil",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          widget.transaction.invoiceId,
          style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildPaperTicket(int subtotal, int total) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.cartItem.activity.title,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                widget.cartItem.activity.city,
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 8),
              Text(
                "${widget.cartItem.quantity} Tiket",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Divider(height: 1, thickness: 1, color: Color(0xFFE2E8F0)),
              ),
              _buildPriceRow("Subtotal", subtotal.toRupiah()),
              const SizedBox(height: 12),
              _buildPriceRow("Biaya Layanan", 3000.toRupiah()),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(total.toRupiah(), style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF2563EB))),
                ],
              ),
            ],
          ),
        ),
        CustomPaint(
          size: const Size(double.infinity, 20),
          painter: TicketZigZagPainter(),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 14)),
        Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14)),
      ],
    );
  }

  Widget _buildTransactionInfo(String date) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Detail Pembayaran", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 20),
          _buildInfoRow("Metode", widget.paymentMethodName),
          const SizedBox(height: 12),
          _buildInfoRow("Tanggal", date),
          const SizedBox(height: 12),
          _buildInfoRow("Status", "SUCCESS"),
          const SizedBox(height: 20),
          if (widget.paymentMethodImage.isNotEmpty)
            Center(child: Image.network(widget.paymentMethodImage, height: 30, fit: BoxFit.contain)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(color: Colors.grey, fontSize: 13)),
        Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13)),
      ],
    );
  }
}

class TicketZigZagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);

    double x = 0;
    double zigzagWidth = 10;
    double zigzagHeight = 8;
    bool up = true;

    while (x < size.width) {
      x += zigzagWidth;
      path.lineTo(x, up ? zigzagHeight : 0);
      up = !up;
    }

    path.lineTo(size.width, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}