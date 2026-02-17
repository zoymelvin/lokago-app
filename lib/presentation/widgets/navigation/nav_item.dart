import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavItem extends StatelessWidget {
  final int index;
  final bool isSelected;
  final IconData outlineIcon;
  final IconData filledIcon;
  final String label;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.outlineIcon,
    required this.filledIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0052CC);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? filledIcon : outlineIcon,
              color: isSelected ? primaryColor : Colors.grey.shade400,
              size: 22,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
              child: isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        label,
                        style: GoogleFonts.poppins(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}