import 'package:union_shop/models/product.dart';

class ProductService {
  static final _items = <String, Product>{
    'T-Shirt': const Product(
      id: 'p1',
      name: 'Classic T-Shirt',
      imageUrl: 'assets/images/UOP_T_Shirt.png',
      images: [
        'assets/images/UOP_T_Shirt.png',
        'assets/images/UOP_T_Shirt_B.png',
        'assets/images/UOP_T_Shirt_W.png',
      ],
      price: 19.99,
      colors: ['White', 'Black', 'Blue'],
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    'Hoodie': const Product(
      id: 'p2',
      name: 'Hoodie',
      imageUrl: 'assets/images/UOP_Hoodie.png',
      images: [
        'assets/images/UOP_Hoodie.png',
      ],
      price: 39.99,
      colors: ['Grey', 'Black'],
      sizes: ['M', 'L', 'XL'],
    ),
    'Winter Jacket': const Product(
      id: 'p3',
      name: 'Winter Jacket',
      imageUrl: 'assets/images/UOP_Jacket.png',
      images: [
        'assets/images/UOP_Jacket.png',
      ],
      price: 45.00,
      colors: ['Black', 'Blue'],
      sizes: ['M', 'L', 'XL'],
    ),
    'Signature Hoodie': const Product(
      id: 'p4',
      name: 'Signature Hoodie',
      imageUrl: 'assets/images/UOP_SH.png',
      images: [
        'assets/images/UOP_SH.png',
      ],
      price: 35,
      colors: ['Green'],
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    'Zipped Hoodie': const Product(
      id: 'p5',
      name: 'Zipped Hoodie',
      imageUrl: 'assets/images/UOP_Zipped.png',
      images: [
        'assets/images/UOP_Zipped.png',
      ],
      price: 40,
      colors: ['Purple'],
      sizes: ['S', 'M', 'L', 'XL'],
    ),
  };
  static Product? getById(String id) {
    // Try direct lookup by map key first
    var p = _items[id];
    if (p != null) return p;
    // Fallback: find by Product.id field
    try {
      return _items.values.firstWhere((prod) => prod.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<Product?> fetchById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return getById(id);
  }
}
