import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokago/presentation/widgets/custom_button.dart';
import 'package:lokago/presentation/widgets/custom_text_field.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/auth_bloc/auth_event.dart';
import '../blocs/auth_bloc/auth_state.dart';
import 'register_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 232, 245),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Selamat Datang di LokaGo!")),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Column(
                    children: [
                      const Icon(Icons.flight_takeoff, size: 80, color: Color(0xFF0052CC)),
                      const SizedBox(height: 10),
                      Text(
                        "LokaGo",
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF002D67),
                        ),
                      ),
                      Text(
                        "Partner Terbaik untuk Jelajahmu",
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                CustomTextField(
                  label: "Email",
                  hint: "Masukkan Email",
                  controller: emailController,
                  icon: Icons.alternate_email_rounded,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  label: "Password",
                  hint: "Masukkan Password",
                  controller: passwordController,
                  icon: Icons.lock_open_rounded,
                  isPassword: true,
                ),
                const SizedBox(height: 40),
                
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      label: "Masuk",
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        context.read<AuthBloc>().add(LoginPressed(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Belum punya akun? Daftar Sekarang",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF0052CC),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}