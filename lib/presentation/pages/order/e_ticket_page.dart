import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:lokago/data/models/transaction_model.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:lokago/presentation/blocs/user_bloc/user_state.dart';

class ETicketPage extends StatelessWidget {
  final TransactionModel transaction;
  const ETicketPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final item = transaction.transactionItems.isNotEmpty ? transaction.transactionItems[0] : null;

    return Scaffold(
      backgroundColor: const Color(0xFF2563EB),
      appBar: AppBar(
        title: Text("E-Tiket", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          Text("LOKAGO OFFICIAL TICKET",
                              style: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.w800, letterSpacing: 1, fontSize: 11)),
                          const SizedBox(height: 24),
                          Text(item?.title ?? "Tiket Aktivitas",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) {
                              String name = "Pelanggan LokaGo";
                              if (state is UserSuccess) name = state.user.name ?? name;
                              return Text(name, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade600));
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    Row(
                      children: [
                        _ticketHole(isLeft: true),
                        Expanded(child: LayoutBuilder(builder: (context, constraints) {
                          return Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate((constraints.constrainWidth() / 12).floor(), (index) => const SizedBox(width: 6, height: 1.5, child: DecoratedBox(decoration: BoxDecoration(color: Color(0xFFE2E8F0))))),
                          );
                        })),
                        _ticketHole(isLeft: false),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 40, 32, 40),
                      child: Column(
                        children: [
                          BarcodeWidget(
                            barcode: Barcode.code128(),
                            data: transaction.id,
                            width: double.infinity,
                            height: 100,
                            drawText: false,
                            color: Colors.black87,
                          ),
                          const SizedBox(height: 20),
                          Text(transaction.invoiceId, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 2)),
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.blue.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)),
                            child: Text("Tunjukkan barcode ini kepada petugas loket untuk proses check-in.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(fontSize: 11, color: Colors.blue.shade700, height: 1.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text("ID Transaksi: ${transaction.id}", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ticketHole({required bool isLeft}) {
    return Container(
      height: 40, width: 20,
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: isLeft 
          ? const BorderRadius.only(topRight: Radius.circular(40), bottomRight: Radius.circular(40)) 
          : const BorderRadius.only(topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
      ),
    );
  }
}