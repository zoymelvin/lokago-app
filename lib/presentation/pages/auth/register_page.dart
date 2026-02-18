import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokago/presentation/widgets/custom_button.dart';
import 'package:lokago/presentation/widgets/custom_text_field.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/auth_bloc/auth_event.dart';
import '../../blocs/auth_bloc/auth_state.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 232, 245),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Pendaftaran Berhasil! Silakan Masuk."), backgroundColor: Colors.green),
            );
            Navigator.pop(context); 
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF002D67), size: 28),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(30, 70, 30, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.inter(
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1A1A1A),
                          height: 1.1,
                        ),
                        children: const [
                          TextSpan(text: "Daftar\nAkun "),
                          TextSpan(
                            text: "LokaGo",
                            style: TextStyle(color: Color(0xFF0052CC)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35),
                    CustomTextField(
                      label: "Nama Lengkap",
                      hint: "Masukkan nama",
                      controller: nameController,
                      icon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: "Email",
                      hint: "Masukkan email",
                      controller: emailController,
                      icon: Icons.alternate_email_rounded,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: "Nomor Telepon",
                      hint: "Masukkan nomor telepon",
                      controller: phoneController,
                      icon: Icons.phone_android_rounded,
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      label: "Password",
                      hint: "Masukkan password",
                      controller: passwordController,
                      icon: Icons.lock_outline_rounded,
                      isPassword: true,
                    ),
                    const SizedBox(height: 40),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return CustomButton(
                          label: "DAFTAR SEKARANG",
                          isLoading: state is AuthLoading,
                          onPressed: () {
                            context.read<AuthBloc>().add(RegisterPressed(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phoneNumber: phoneController.text,
                                  password: passwordController.text,
                                ));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}