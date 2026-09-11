import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C63FF)
              : const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF6C63FF)
                : const Color(0xFF6C63FF).withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Text(category.icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            Text(
              category.name,
              style: GoogleFonts.montserrat(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
