import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/models/product_model.dart';
import '../../data/models/category_model.dart';

class HomeController extends GetxController {
  var products = <Product>[].obs;
  var categories = <Category>[].obs;
  var exclusiveOffers = <Product>[].obs;
  var bestSellingProducts = <Product>[].obs;
  var isLoading = true.obs;
  var selectedCategory = ''.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    _loadData();
    isLoading.value = false;
  }

  void _loadData() {
    categories.value = [
      Category(id: '1', name: 'Vegetables', icon: '🥬', imageUrl: '', productCount: 6),
      Category(id: '2', name: 'Fruits', icon: '🍎', imageUrl: '', productCount: 6),
      Category(id: '3', name: 'Dairy', icon: '🥛', imageUrl: '', productCount: 4),
      Category(id: '4', name: 'Meat', icon: '🥩', imageUrl: '', productCount: 3),
      Category(id: '5', name: 'Bakery', icon: '🍞', imageUrl: '', productCount: 3),
      Category(id: '6', name: 'Beverages', icon: '🥤', imageUrl: '', productCount: 2),
      Category(id: '7', name: 'Seafood', icon: '🦐', imageUrl: '', productCount: 2),
      Category(id: '8', name: 'Snacks', icon: '🍿', imageUrl: '', productCount: 2),
    ];

    products.value = [
      Product(
        id: '1',
        name: 'Organic Bananas',
        description: 'Fresh organic bananas from local farms.',
        price: 4.99,
        category: 'Fruits',
        imageUrl: 'https://images.unsplash.com/photo-1603833665858-e61d17a86224?w=400',
        unit: '7 pcs',
        rating: 4.8,
        reviewCount: 120,
        isOrganic: true,
        discount: 15,
        isFeatured: true,
      ),
      Product(
        id: '2',
        name: 'Red Apple',
        description: 'Crispy and sweet red apples.',
        price: 4.99,
        category: 'Fruits',
        imageUrl: 'https://images.unsplash.com/photo-1568702846914-96b305d2aaeb?w=400',
        unit: '1 kg',
        rating: 4.6,
        reviewCount: 95,
        discount: 10,
        isFeatured: true,
      ),
      Product(
        id: '3',
        name: 'Fresh Strawberry',
        description: 'Sweet and juicy strawberries.',
        price: 6.99,
        category: 'Fruits',
        imageUrl: 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=400',
        unit: '500g',
        rating: 4.9,
        reviewCount: 150,
        isOrganic: true,
        discount: 20,
        isFeatured: true,
      ),
      Product(
        id: '4',
        name: 'Green Grapes',
        description: 'Fresh green grapes.',
        price: 5.99,
        category: 'Fruits',
        imageUrl: 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=400',
        unit: '1 kg',
        rating: 4.7,
        reviewCount: 80,
        discount: 5,
      ),
      Product(
        id: '5',
        name: 'Fresh Orange',
        description: 'Juicy oranges packed with vitamin C.',
        price: 3.99,
        category: 'Fruits',
        imageUrl: 'https://images.unsplash.com/photo-1547514701-42782101795e?w=400',
        unit: '1 kg',
        rating: 4.5,
        reviewCount: 110,
        isOrganic: true,
      ),
      Product(
        id: '6',
        name: 'Watermelon',
        description: 'Sweet and refreshing watermelon.',
        price: 7.99,
        category: 'Fruits',
        imageUrl: 'https://images.unsplash.com/photo-1587049352846-4a222e784d38?w=400',
        unit: '1 pc',
        rating: 4.8,
        reviewCount: 65,
        discount: 12,
      ),
      Product(
        id: '7',
        name: 'Fresh Broccoli',
        description: 'Fresh green broccoli.',
        price: 3.99,
        category: 'Vegetables',
        imageUrl: 'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400',
        unit: '500g',
        rating: 4.5,
        reviewCount: 60,
        isOrganic: true,
      ),
      Product(
        id: '8',
        name: 'Fresh Carrot',
        description: 'Fresh orange carrots.',
        price: 2.99,
        category: 'Vegetables',
        imageUrl: 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=400',
        unit: '1 kg',
        rating: 4.4,
        reviewCount: 45,
        isOrganic: true,
      ),
      Product(
        id: '9',
        name: 'Ripe Tomato',
        description: 'Ripe and juicy tomatoes.',
        price: 3.49,
        category: 'Vegetables',
        imageUrl: 'https://images.unsplash.com/photo-1546094096-0df4bcaaa337?w=400',
        unit: '1 kg',
        rating: 4.6,
        reviewCount: 90,
        isOrganic: true,
        discount: 8,
      ),
      Product(
        id: '10',
        name: 'Cucumber',
        description: 'Fresh and crispy cucumbers.',
        price: 2.49,
        category: 'Vegetables',
        imageUrl: 'https://images.unsplash.com/photo-1604977042946-1eecc30f269e?w=400',
        unit: '500g',
        rating: 4.3,
        reviewCount: 40,
        isOrganic: true,
      ),
      Product(
        id: '11',
        name: 'Fresh Spinach',
        description: 'Fresh organic spinach.',
        price: 4.49,
        category: 'Vegetables',
        imageUrl: 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=400',
        unit: '250g',
        rating: 4.7,
        reviewCount: 75,
        isOrganic: true,
        discount: 10,
      ),
      Product(
        id: '12',
        name: 'Bell Pepper',
        description: 'Colorful bell peppers.',
        price: 3.99,
        category: 'Vegetables',
        imageUrl: 'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=400',
        unit: '3 pcs',
        rating: 4.5,
        reviewCount: 55,
      ),
      Product(
        id: '13',
        name: 'Fresh Milk',
        description: 'Fresh whole milk from local farms.',
        price: 4.99,
        category: 'Dairy',
        imageUrl: 'https://images.unsplash.com/photo-1550583724-b2692b85b150?w=400',
        unit: '1 L',
        rating: 4.8,
        reviewCount: 200,
        isOrganic: true,
        discount: 5,
        isFeatured: true,
      ),
      Product(
        id: '14',
        name: 'Cheddar Cheese',
        description: 'Aged cheddar cheese.',
        price: 6.99,
        category: 'Dairy',
        imageUrl: 'https://images.unsplash.com/photo-1486297678162-eb2a19b0a32d?w=400',
        unit: '200g',
        rating: 4.7,
        reviewCount: 130,
      ),
      Product(
        id: '15',
        name: 'Greek Yogurt',
        description: 'Creamy Greek yogurt.',
        price: 5.99,
        category: 'Dairy',
        imageUrl: 'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=400',
        unit: '500g',
        rating: 4.9,
        reviewCount: 180,
        isOrganic: true,
        discount: 15,
        isFeatured: true,
      ),
      Product(
        id: '16',
        name: 'Fresh Butter',
        description: 'Creamy butter from fresh milk.',
        price: 3.99,
        category: 'Dairy',
        imageUrl: 'https://images.unsplash.com/photo-1589985270826-4b7bb135bc9d?w=400',
        unit: '250g',
        rating: 4.6,
        reviewCount: 95,
      ),
      Product(
        id: '17',
        name: 'Chicken Breast',
        description: 'Fresh chicken breast.',
        price: 8.99,
        category: 'Meat',
        imageUrl: 'https://images.unsplash.com/photo-1604503468506-a8da13d82791?w=400',
        unit: '500g',
        rating: 4.8,
        reviewCount: 160,
        isOrganic: true,
        discount: 10,
        isFeatured: true,
      ),
      Product(
        id: '18',
        name: 'Beef Steak',
        description: 'Premium beef steak.',
        price: 14.99,
        category: 'Meat',
        imageUrl: 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?w=400',
        unit: '400g',
        rating: 4.9,
        reviewCount: 140,
        isOrganic: true,
      ),
      Product(
        id: '19',
        name: 'Pork Chops',
        description: 'Tender pork chops.',
        price: 9.99,
        category: 'Meat',
        imageUrl: 'https://images.unsplash.com/photo-1432139555190-58524dae6a55?w=400',
        unit: '500g',
        rating: 4.6,
        reviewCount: 85,
      ),
      Product(
        id: '20',
        name: 'Sourdough Bread',
        description: 'Freshly baked sourdough bread.',
        price: 4.99,
        category: 'Bakery',
        imageUrl: 'https://images.unsplash.com/photo-1585478259715-876acc5be8eb?w=400',
        unit: '1 loaf',
        rating: 4.9,
        reviewCount: 200,
        isOrganic: true,
        discount: 5,
        isFeatured: true,
      ),
      Product(
        id: '21',
        name: 'Butter Croissant',
        description: 'Buttery and flaky croissants.',
        price: 3.49,
        category: 'Bakery',
        imageUrl: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?w=400',
        unit: '2 pcs',
        rating: 4.8,
        reviewCount: 175,
      ),
      Product(
        id: '22',
        name: 'Vanilla Cupcake',
        description: 'Delicious vanilla cupcakes.',
        price: 4.49,
        category: 'Bakery',
        imageUrl: 'https://images.unsplash.com/photo-1614707267537-b85aaf00c4b7?w=400',
        unit: '4 pcs',
        rating: 4.7,
        reviewCount: 120,
        discount: 12,
      ),
      Product(
        id: '23',
        name: 'Orange Juice',
        description: '100% pure orange juice.',
        price: 5.99,
        category: 'Beverages',
        imageUrl: 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=400',
        unit: '1 L',
        rating: 4.7,
        reviewCount: 160,
        isOrganic: true,
      ),
      Product(
        id: '24',
        name: 'Coffee Beans',
        description: 'Premium Arabica coffee beans.',
        price: 12.99,
        category: 'Beverages',
        imageUrl: 'https://images.unsplash.com/photo-1559056199-641a0ac8b55e?w=400',
        unit: '500g',
        rating: 4.9,
        reviewCount: 220,
        isOrganic: true,
        discount: 8,
        isFeatured: true,
      ),
      Product(
        id: '25',
        name: 'Salmon Fillet',
        description: 'Fresh Atlantic salmon.',
        price: 14.99,
        category: 'Seafood',
        imageUrl: 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=400',
        unit: '400g',
        rating: 4.9,
        reviewCount: 150,
        isOrganic: true,
        discount: 10,
        isFeatured: true,
      ),
      Product(
        id: '26',
        name: 'Wild Shrimp',
        description: 'Fresh wild-caught shrimp.',
        price: 11.99,
        category: 'Seafood',
        imageUrl: 'https://images.unsplash.com/photo-1565680018434-b513d5e5fd47?w=400',
        unit: '500g',
        rating: 4.8,
        reviewCount: 130,
      ),
      Product(
        id: '27',
        name: 'Gourmet Popcorn',
        description: 'Gourmet popcorn.',
        price: 3.99,
        category: 'Snacks',
        imageUrl: 'https://images.unsplash.com/photo-1578849278619-e73505e9610f?w=400',
        unit: '150g',
        rating: 4.5,
        reviewCount: 100,
        isOrganic: true,
      ),
      Product(
        id: '28',
        name: 'Healthy Trail Mix',
        description: 'Healthy mix of nuts and dried fruits.',
        price: 5.99,
        category: 'Snacks',
        imageUrl: 'https://images.unsplash.com/photo-1599599810694-b5b37304c041?w=400',
        unit: '250g',
        rating: 4.6,
        reviewCount: 90,
        isOrganic: true,
      ),
    ];

    exclusiveOffers.value = products.where((p) => p.discount > 0).toList();
    final sorted = List<Product>.from(products);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    bestSellingProducts.value = sorted.take(4).toList();
  }

  List<Product> get filteredProducts {
    List<Product> result = products.toList();
    if (selectedCategory.value.isNotEmpty) {
      result = result.where((p) => p.category == selectedCategory.value).toList();
    }
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase().trim();
      result = result.where((p) =>
        p.name.toLowerCase().contains(query) ||
        p.category.toLowerCase().contains(query) ||
        p.description.toLowerCase().contains(query)).toList();
    }
    return result;
  }

  void searchProducts(String query) => searchQuery.value = query;

  void toggleFavorite(String productId) {
    Get.snackbar('❤️ Favorite', 'Added to favorites',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF6C63FF),
      colorText: Colors.white,
      duration: const Duration(seconds: 2));
  }

  Future<void> refreshData() async => await fetchData();
}
