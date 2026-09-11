import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/product_card.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

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
          'Special Offers',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        final offers = homeController.exclusiveOffers;
        if (offers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.local_offer_outlined, color: Colors.grey, size: 60),
                const SizedBox(height: 16),
                Text(
                  'No offers available',
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
          itemCount: offers.length,
          itemBuilder: (ctx, i) {
            final p = offers[i];
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
