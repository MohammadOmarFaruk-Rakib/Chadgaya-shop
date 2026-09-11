import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Search',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A3E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                ),
              ),
              child: TextField(
                onChanged: (v) {
                  homeController.searchQuery.value = v;
                  homeController.searchProducts(v);
                },
                autofocus: true,
                style: GoogleFonts.montserrat(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade500),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF6C63FF)),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final results = homeController.filteredProducts;
              if (results.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off, color: Colors.grey, size: 60),
                      const SizedBox(height: 16),
                      Text(
                        'No results found',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.65,
                ),
                itemCount: results.length,
                itemBuilder: (ctx, i) {
                  final p = results[i];
                  return ProductCard(
                    product: p,
                    onTap: () => Get.toNamed('/product/${p.id}', arguments: p),
                    onAddToCart: () => cartController.addItem(p),
                    onFavorite: () => homeController.toggleFavorite(p.id),
                    isGridView: true,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
