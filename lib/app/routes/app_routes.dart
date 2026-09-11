import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Import all screens
import '../../presentation/screens/splash_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/profile_screen.dart';
import '../../presentation/screens/cart_screen.dart';
import '../../presentation/screens/search_screen.dart';
import '../../presentation/screens/explore_screen.dart';
import '../../presentation/screens/offers_screen.dart';
import '../../presentation/screens/category_products_screen.dart';
import '../../presentation/screens/product_detail_screen.dart';
import '../../presentation/screens/admin_product_screen.dart';
import '../../presentation/screens/add_product_screen.dart';

// Import models and controllers
import '../../data/models/product_model.dart';
import '../../presentation/controllers/home_controller.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String cart = '/cart';
  static const String search = '/search';
  static const String explore = '/explore';
  static const String favorites = '/favorites';
  static const String offers = '/offers';
  static const String category = '/category/:name';
  static const String productDetail = '/product/:id';
  static const String adminProducts = '/admin/products';
  static const String adminProductAdd = '/admin/product/add';
  static const String adminProductEdit = '/admin/product/edit/:id';

  // All routes
  static List<GetPage> routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: cart,
      page: () => const CartScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: search,
      page: () => const SearchScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: explore,
      page: () => const ExploreScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: favorites,
      page: () => const Scaffold(
        body: Center(child: Text('Favorites Screen Coming Soon')),
      ),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: offers,
      page: () => const OffersScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: category,
      page: () => const CategoryProductsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: productDetail,
      page: () {
        final product = Get.arguments as Product?;
        if (product == null) {
          return Scaffold(
            backgroundColor: const Color(0xFF0A0A1A),
            appBar: AppBar(
              title: const Text('Error'),
              backgroundColor: const Color(0xFF0A0A1A),
              foregroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
            body: const Center(
              child: Text(
                'Product data missing or failed to load.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }
        return ProductDetailScreen(product: product);
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: adminProducts,
      page: () => const AdminProductScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: adminProductAdd,
      page: () => const AddProductScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: adminProductEdit,
      page: () {
        final String id = Get.parameters['id'] ?? '';
        final product = Get.find<HomeController>().products.firstWhere(
          (p) => p.id == id,
          orElse: () => throw Exception('Product not found'),
        );
        return AddProductScreen(productToEdit: product);
      },
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
