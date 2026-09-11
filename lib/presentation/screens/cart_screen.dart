import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/cart_controller.dart';
import '../../data/models/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'My Cart',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return _buildEmptyCart();
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(16),
                itemCount: cartController.cartItems.length,
                itemBuilder: (ctx, i) {
                  return _buildCartItem(cartController.cartItems[i],
                      cartController);
                },
              ),
            ),
            _buildSummary(cartController),
          ],
        );
      }),
    );
  }

  Widget _buildCartItem(CartItem item, CartController controller) {
    final product = item.product;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A3E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
  borderRadius: BorderRadius.circular(10),
  child: Container(
    width: 70,
    height: 70,
    color: const Color(0xFF2A2A4E),
    child: Image.network(
      product.imageUrl,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              color: Color(0xFF6C63FF),
              strokeWidth: 2,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.image_not_supported, color: Colors.grey);
      },
    ),
  ),
),

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  product.unit,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${product.discountedPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF6C63FF),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (item.quantity > 1) {
                        controller.updateQuantity(
                            product.id, item.quantity - 1);
                      } else {
                        controller.removeItem(product.id);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2A2A4E),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.remove,
                          color: Colors.white, size: 16),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    item.quantity.toString(),
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => controller.updateQuantity(
                        product.id, item.quantity + 1),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Color(0xFF6C63FF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add,
                          color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => controller.removeItem(product.id),
                child: Text(
                  'Remove',
                  style: GoogleFonts.montserrat(
                    fontSize: 11,
                    color: Colors.red.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(CartController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A3E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          _buildRow('Subtotal', '\$${controller.total.toStringAsFixed(2)}'),
          if (controller.totalDiscount > 0)
            _buildRow(
              'Discount',
              '-\$${controller.totalDiscount.toStringAsFixed(2)}',
              color: Colors.green,
            ),
          _buildRow('Delivery', '\$0.00'),
          const Divider(color: Colors.grey, height: 16),
          _buildRow(
            'Total',
            '\$${controller.finalTotal.toStringAsFixed(2)}',
            isTotal: true,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _showCheckout(controller),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Checkout • \$${controller.finalTotal.toStringAsFixed(2)}',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value,
      {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
              color: isTotal ? Colors.white : Colors.grey.shade400,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: color ??
                  (isTotal ? const Color(0xFF6C63FF) : Colors.grey.shade300),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A3E),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.shopping_cart_outlined,
                color: Color(0xFF6C63FF), size: 60),
          ),
          const SizedBox(height: 24),
          Text(
            'Your Cart is Empty',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start shopping to fill your cart!',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => Get.toNamed('/home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C63FF),
              padding: const EdgeInsets.symmetric(
                  horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Start Shopping',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCheckout(CartController controller) {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1A1A3E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF00C853).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded,
                    color: Color(0xFF00C853), size: 40),
              ),
              const SizedBox(height: 16),
              Text(
                'Order Confirmed! 🎉',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Total: \$${controller.finalTotal.toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF6C63FF),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.clearCart();
                    Get.back();
                    Get.toNamed('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Continue Shopping',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
