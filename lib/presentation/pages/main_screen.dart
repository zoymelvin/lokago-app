import 'package:flutter/material.dart';
import 'home_page.dart';
import '../widgets/navigation/custom_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text("Pesanan")),
    const Center(child: Text("Favorit")),
    const Center(child: Text("Akun")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      body: Stack(
        children: [
          _pages[_selectedIndex],

          _buildBottomOverlay(),

          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: CustomBottomBar(
              selectedIndex: _selectedIndex,
              onItemSelected: (index) {
                setState(() => _selectedIndex = index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomOverlay() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFF6F8FB).withValues(alpha: 0.0),
              const Color(0xFFF6F8FB).withValues(alpha: 0.8),
            ],
          ),
        ),
      ),
    );
  }
}