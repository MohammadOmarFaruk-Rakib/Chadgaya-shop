import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/product_model.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  // Total number of items in cart
  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);

  // Subtotal (before discount)
  double get total => cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);

  // Total discount amount
  double get totalDiscount => cartItems.fold(
        0.0,
        (sum, item) =>
            sum +
            ((item.product.price - item.product.discountedPrice) *
                item.quantity),
      );

  // Final total after discount
  double get finalTotal => total - totalDiscount;

  // ========== ADD ITEM ==========
  void addItem(Product product, {int quantity = 1}) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      cartItems[existingIndex].quantity += quantity;
    } else {
      cartItems.add(CartItem(product: product, quantity: quantity));
    }

    Get.snackbar(
      '🛒 Added to Cart',
      '${product.name} added successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1A1A3E),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      borderColor: const Color(0xFF6C63FF),
      borderWidth: 2,
      icon: const Icon(
        Icons.check_circle_rounded,
        color: Color(0xFF00C853),
      ),
    );
  }

  // ========== REMOVE ITEM ==========
  void removeItem(String productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  // ========== UPDATE QUANTITY ==========
  void updateQuantity(String productId, int quantity) {
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index].quantity = quantity;
      }
    }
  }

  // ========== CLEAR CART ==========
  void clearCart() {
    cartItems.clear();
  }
}
