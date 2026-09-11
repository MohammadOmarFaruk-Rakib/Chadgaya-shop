class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final String imagePath;
  final String unit;
  final double rating;
  final int reviewCount;
  final bool isOrganic;
  final bool isFeatured;
  final double discount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.imagePath = '',
    required this.unit,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isOrganic = false,
    this.isFeatured = false,
    this.discount = 0.0,
  });

  double get discountedPrice => price - (price * discount / 100);
}
