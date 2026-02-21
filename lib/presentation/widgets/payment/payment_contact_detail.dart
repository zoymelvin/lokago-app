import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_bloc/user_state.dart';

class PaymentContactDetail extends StatelessWidget {
  const PaymentContactDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          String name = "Memuat...";
          String email = "Memuat...";
          if (state is UserSuccess) {
            name = state.user.name ?? "-";
            email = state.user.email ?? "-";
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Detail Pemesan", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _infoTile("Nama", name),
              const SizedBox(height: 8),
              _infoTile("Email", email),
            ],
          );
        },
      ),
    );
  }

  Widget _infoTile(String l, String v) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          Text(v, style: const TextStyle(fontWeight: FontWeight.w500)),
        ]),
      );
}