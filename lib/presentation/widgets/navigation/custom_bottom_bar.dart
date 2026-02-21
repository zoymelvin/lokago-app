import 'package:flutter/material.dart';
import 'nav_item.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 25,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          NavItem(
            index: 0,
            isSelected: selectedIndex == 0,
            outlineIcon: Icons.home_outlined,
            filledIcon: Icons.home_rounded,
            label: "Beranda",
            onTap: () => onItemSelected(0),
          ),
          NavItem(
            index: 1,
            isSelected: selectedIndex == 1,
            outlineIcon: Icons.shopping_bag_outlined,
            filledIcon: Icons.shopping_bag_rounded,
            label: "Pesanan",
            onTap: () => onItemSelected(1),
          ),
          NavItem(
            index: 2,
            isSelected: selectedIndex == 2,
            outlineIcon: Icons.shopping_cart_outlined,
            filledIcon: Icons.shopping_cart,
            label: "Keranjang",
            onTap: () => onItemSelected(2),
          ),

          NavItem(
            index: 3,
            isSelected: selectedIndex == 3,
            outlineIcon: Icons.person_outline_rounded,
            filledIcon: Icons.person_rounded,
            label: "Akun",
            onTap: () => onItemSelected(3),
          ),
        ],
      ),
    );
  }
}