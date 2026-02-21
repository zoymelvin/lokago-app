import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokago/presentation/pages/profile/change_password_page.dart';
import 'package:lokago/presentation/pages/profile/edit_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../blocs/user_bloc/user_state.dart';
import '../../widgets/account/account_menu_card.dart';
import '../../widgets/account/account_menu_item.dart';
import '../auth/login_page.dart';
import 'help_center_page.dart';
import 'privacy_policy_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          "Konfirmasi Keluar",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF002D67),
          ),
        ),
        content: Text(
          "Apakah Anda yakin ingin keluar ?",
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              "Batal",
              style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
            child: Text(
              "Ya",
              style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Akun Seting",
          style: GoogleFonts.poppins(
            color: const Color(0xFF002D67),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF0052CC)));
          }

          if (state is UserSuccess) {
            final user = state.user;
            return SingleChildScrollView(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(user.profilePictureUrl ?? "https://i.pravatar.cc/150"),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name ?? "Traveler",
                                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF002D67)),
                              ),
                              Text(
                                user.email ?? "-",
                                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 15),

                  AccountMenuCard(
                    children: [
                      AccountMenuItem(
                        icon: Icons.lock_outline_rounded,
                        title: "Ganti Password",
                        subtitle: "Perbarui keamanan kata sandi akun Anda",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
                        },
                      ),
                      AccountMenuItem(
                        icon: Icons.person_outline_rounded,
                        title: "Edit Profil",
                        subtitle: "Kelola informasi data diri dan kontak",
                        onTap: () {
                            Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => EditProfilePage(user: state.user))
                            );
                          },
                      ),
                    ],
                  ),

                  AccountMenuCard(
                    children: [
                      AccountMenuItem(
                        icon: Icons.help_outline_rounded,
                        title: "Pusat Bantuan",
                        subtitle: "Temukan jawaban atau hubungi CS kami",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterPage()));
                        },
                      ),
                      AccountMenuItem(
                        icon: Icons.privacy_tip_outlined,
                        title: "Kebijakan Privasi",
                        subtitle: "Cara kami melindungi data pribadi Anda",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()));
                        },
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _handleLogout(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade50,
                          foregroundColor: Colors.red,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                        child: const Text("Keluar dari Akun", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ),
                  ),
                  
                  const Text("v1.0.0", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 120),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}