import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/product_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1A),
        elevation: 0,
        title: Text(
          'Explore',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        final products = homeController.products;
        if (products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
          );
        }
        return GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
          ),
          itemCount: products.length,
          itemBuilder: (ctx, i) {
            final p = products[i];
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
    );
  }
}
