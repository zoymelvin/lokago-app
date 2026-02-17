import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../data/models/category_model.dart';

class HomeCategorySection extends StatelessWidget {
  final List<CategoryModel> categories;
  const HomeCategorySection({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final allowedCountries = ['Malaysia', 'Brazil', 'Canada', 'Thailand', 'Japan', 'Taiwan', 'Hongkong', 'France'];
    final filteredCategories = categories.where((cat) => 
      allowedCountries.any((country) => cat.name!.toLowerCase().contains(country.toLowerCase()))).toList();

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 20),
        itemCount: filteredCategories.length,
        itemBuilder: (context, index) {
          final cat = filteredCategories[index];
          return Container(
            width: 240,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: NetworkImage(cat.imageUrl ?? ''), fit: BoxFit.cover),
            ),
            child: Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                ),
              ),
              child: Text(
                cat.name ?? '',
                style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          );
        },
      ),
    );
  }
}