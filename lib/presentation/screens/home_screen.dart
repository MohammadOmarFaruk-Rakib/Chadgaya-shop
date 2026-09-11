import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/category_card.dart';
import '../widgets/app_footer.dart';
import '../../data/models/product_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    final cartController = Get.put(CartController());

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: _buildAppBar(),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6C63FF)),
          );
        }

        final isSearching = homeController.searchQuery.value.isNotEmpty;

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(homeController),
              if (isSearching) ...[
                const SizedBox(height: 12),
                _buildProductGrid(
                  homeController.filteredProducts,
                  homeController,
                  cartController,
                ),
              ],
              if (!isSearching) ...[
                const SizedBox(height: 16),
                _buildCategories(homeController),
                const SizedBox(height: 24),
                _buildBanner(),
                const SizedBox(height: 24),
                _buildSection(
                  'Exclusive Offer',
                  homeController.exclusiveOffers,
                  homeController,
                  cartController,
                ),
                const SizedBox(height: 24),
                _buildSection(
                  'Best Selling',
                  homeController.bestSellingProducts,
                  homeController,
                  cartController,
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'All Products',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildProductGrid(
                  homeController.filteredProducts,
                  homeController,
                  cartController,
                ),
              ],
              const AppFooter(),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0A0A1A),
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.fastfood_rounded,
              color: Color(0xFF6C63FF),
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Chadgaya',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () => Get.toNamed('/profile'),
              icon: const Icon(Icons.person_outline, color: Colors.white),
            ),
            Positioned(
              right: 6,
              top: 4,
              child: Obx(() {
                final c = Get.find<CartController>().itemCount;
                if (c > 0) {
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$c',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBar(HomeController c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A3E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: c.searchQuery.value.isNotEmpty
                ? const Color(0xFF6C63FF)
                : const Color(0xFF6C63FF).withValues(alpha: 0.2),
          ),
        ),
        child: TextField(
          onChanged: (v) {
            c.searchQuery.value = v;
            c.searchProducts(v);
          },
          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: 'Search Store',
            hintStyle: GoogleFonts.montserrat(
              color: Colors.grey.shade500,
              fontSize: 14,
            ),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF6C63FF)),
            suffixIcon: Obx(() {
              if (c.searchQuery.value.isNotEmpty) {
                return IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    c.searchQuery.value = '';
                    c.searchProducts('');
                  },
                );
              }
              return const SizedBox.shrink();
            }),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategories(HomeController c) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: c.categories.length,
        itemBuilder: (ctx, i) {
          final cat = c.categories[i];
          return Obx(() {
            final isSelected = c.selectedCategory.value == cat.name;
            return CategoryCard(
              category: cat,
              isSelected: isSelected,
              onTap: () {
                Get.toNamed('/category/${cat.name}');
              },
            );
          });
        },
      ),
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF8B5CF6)],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fresh Vegetables',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Get Up To 40% OFF',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            const Text('🥬', style: TextStyle(fontSize: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Product> products,
    HomeController home,
    CartController cart,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (ctx, i) {
                final p = products[i];
                return ProductCard(
                  product: p,
                  onTap: () => Get.toNamed('/product/${p.id}', arguments: p),
                  onAddToCart: () => cart.addItem(p),
                  onFavorite: () => home.toggleFavorite(p.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(
    List<Product> products,
    HomeController home,
    CartController cart,
  ) {
    if (products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.search_off, color: Colors.grey, size: 60),
              const SizedBox(height: 16),
              Text(
                'No products found',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.65,
        ),
        itemCount: products.length,
        itemBuilder: (ctx, i) {
          final p = products[i];
          return ProductCard(
            product: p,
            onTap: () => Get.toNamed('/product/${p.id}', arguments: p),
            onAddToCart: () => cart.addItem(p),
            onFavorite: () => home.toggleFavorite(p.id),
            isGridView: true,
          );
        },
      ),
    );
  }

  Widget _buildBottomNav() {
    return Obx(() {
      final cartCount = Get.find<CartController>().itemCount;
      return Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0A0A1A), Color(0xFF1A1A3E)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
              blurRadius: 20,
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 0,
          onTap: (i) {
            switch (i) {
              case 0:
                Get.toNamed('/home');
                break;
              case 1:
                Get.toNamed('/explore');
                break;
              case 2:
                Get.toNamed('/cart');
                break;
              case 3:
                Get.toNamed('/favorites');
                break;
            }
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: const Color(0xFF6C63FF),
          unselectedItemColor: Colors.grey.shade600,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Shop',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.shopping_cart_outlined),
                  if (cartCount > 0)
                    Positioned(
                      right: -6,
                      top: -6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: const Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: 'Favourite',
            ),
          ],
        ),
      );
    });
  }
}
