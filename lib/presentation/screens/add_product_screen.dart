import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';
import '../../data/models/product_model.dart';

class AddProductScreen extends StatelessWidget {
  final Product? productToEdit;

  const AddProductScreen({super.key, this.productToEdit});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final isEditing = productToEdit != null;

    final nameCtrl = TextEditingController(text: productToEdit?.name ?? '');
    final priceCtrl =
        TextEditingController(text: productToEdit?.price.toString() ?? '');
    final categoryCtrl =
        TextEditingController(text: productToEdit?.category ?? '');
    final unitCtrl = TextEditingController(text: productToEdit?.unit ?? '');
    final descCtrl =
        TextEditingController(text: productToEdit?.description ?? '');

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A1A),
        elevation: 0,
        title: Text(
          isEditing ? 'Edit Product' : 'Add Product',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Validate
              if (nameCtrl.text.trim().isEmpty ||
                  priceCtrl.text.trim().isEmpty ||
                  categoryCtrl.text.trim().isEmpty) {
                Get.snackbar(
                  'Error',
                  'Please fill all required fields',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              // Save
              if (isEditing) {
                final index = controller.products
                    .indexWhere((p) => p.id == productToEdit!.id);
                if (index != -1) {
                  controller.products[index] = Product(
                    id: productToEdit!.id,
                    name: nameCtrl.text.trim(),
                    description: descCtrl.text.trim(),
                    price: double.parse(priceCtrl.text.trim()),
                    category: categoryCtrl.text.trim(),
                    imageUrl: productToEdit!.imageUrl,
                    unit: unitCtrl.text.trim(),
                    rating: productToEdit!.rating,
                    reviewCount: productToEdit!.reviewCount,
                    isOrganic: productToEdit!.isOrganic,
                    discount: productToEdit!.discount,
                    isFeatured: productToEdit!.isFeatured,
                  );
                }
              } else {
                controller.products.add(
                  Product(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: nameCtrl.text.trim(),
                    description: descCtrl.text.trim(),
                    price: double.parse(priceCtrl.text.trim()),
                    category: categoryCtrl.text.trim(),
                    imageUrl: '🛍️',
                    unit: unitCtrl.text.trim(),
                  ),
                );
              }

              Get.back();
              Get.snackbar(
                isEditing ? '✅ Updated' : '✅ Added',
                '${nameCtrl.text.trim()} has been saved',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF00C853),
                colorText: Colors.white,
              );
            },
            child: Text(
              isEditing ? 'UPDATE' : 'SAVE',
              style: GoogleFonts.montserrat(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6C63FF),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField(nameCtrl, 'Product Name', 'Enter product name'),
            const SizedBox(height: 16),
            _buildField(
              priceCtrl,
              'Price',
              'Enter price',
              keyboard: TextInputType.number,
            ),
            const SizedBox(height: 16),
            _buildField(categoryCtrl, 'Category', 'Enter category'),
            const SizedBox(height: 16),
            _buildField(unitCtrl, 'Unit', 'e.g., 1 kg, 500g, 7 pcs'),
            const SizedBox(height: 16),
            _buildField(
              descCtrl,
              'Description',
              'Enter product description',
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A3E),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined,
                      color: Colors.grey.shade600, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to upload product image',
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField(
    TextEditingController ctrl,
    String label,
    String hint, {
    TextInputType? keyboard,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          keyboardType: keyboard,
          maxLines: maxLines,
          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.montserrat(color: Colors.grey.shade500),
            filled: true,
            fillColor: const Color(0xFF1A1A3E),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}
