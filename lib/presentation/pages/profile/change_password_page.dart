import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_bloc/user_event.dart';
import '../../blocs/user_bloc/user_state.dart';
import '../../widgets/custom_text_field.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: Text("Ganti Password", 
          style: GoogleFonts.poppins(color: const Color(0xFF002D67), fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password berhasil diperbarui!"), backgroundColor: Colors.green),
            );
            Navigator.pop(context);
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ganti Kata Sandi", 
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF0052CC))),
              const SizedBox(height: 10),
              Text("Pastikan password baru Anda kuat dan sulit ditebak orang lain.",
                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600)),
              const SizedBox(height: 30),

              CustomTextField(
                label: "Password Lama",
                hint: "Masukkan password saat ini",
                controller: oldPasswordController,
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Password Baru",
                hint: "Masukkan password baru",
                controller: newPasswordController,
                icon: Icons.vpn_key_outlined,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Konfirmasi Password Baru",
                hint: "Ulangi password baru",
                controller: confirmPasswordController,
                icon: Icons.check_circle_outline,
                isPassword: true,
              ),
              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is UserLoading ? null : () {
                        if (newPasswordController.text != confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Konfirmasi password tidak cocok"), backgroundColor: Colors.orange),
                          );
                          return;
                        }
                        context.read<UserBloc>().add(ChangePasswordPressed(
                          oldPassword: oldPasswordController.text,
                          newPassword: newPasswordController.text,
                          confirmPassword: confirmPasswordController.text,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0052CC),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: state is UserLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Update Password", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}