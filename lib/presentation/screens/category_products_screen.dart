import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/product_card.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final cartController = Get.find<CartController>();
    final String categoryName = Get.parameters['name'] ?? 'Category';

    final category = homeController.categories.firstWhere(
      (c) => c.name.toLowerCase() == categoryName.toLowerCase(),
      orElse: () => homeController.categories.first,
    );

    final categoryProducts = homeController.products
        .where((p) => p.category.toLowerCase() == categoryName.toLowerCase())
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            Text(category.icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              category.name,
              style: GoogleFonts.montserrat(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6C63FF).withValues(alpha: 0.2),
                  const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      category.icon,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category.name,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${categoryProducts.length} products available',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Products Grid
          Expanded(
            child: categoryProducts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.inventory_2_outlined,
                            color: Colors.grey, size: 60),
                        const SizedBox(height: 16),
                        Text(
                          'No products in this category',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: categoryProducts.length,
                    itemBuilder: (ctx, i) {
                      final p = categoryProducts[i];
                      return ProductCard(
                        product: p,
                        onTap: () =>
                            Get.toNamed('/product/${p.id}', arguments: p),
                        onAddToCart: () => cartController.addItem(p),
                        onFavorite: () =>
                            homeController.toggleFavorite(p.id),
                        isGridView: true,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
