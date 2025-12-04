class Product {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> images;
  final double price;
  final List<String> colors;
  final List<String> sizes;

  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.images = const [],
    this.colors = const [],
    this.sizes = const [],
  });
}
