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
    'Beanie': const Product(
      id: 'p6',
      name: 'Beanie',
      imageUrl: 'assets/images/Beanie.png',
      images: [
        'assets/images/Beanie.png',
      ],
      price: 12.50,
      colors: ['Red', 'Black'],
      sizes: [],
    ),
    'Bow tie': const Product(
      id: 'p7',
      name: 'Bow tie',
      imageUrl: 'assets/images/Bow_tie.png',
      images: [
        'assets/images/Bow_tie.png',
      ],
      price: 15.00,
      colors: ['Navy'],
      sizes: [],
    ),
    'Halloween Tote Bag': const Product(
      id: 'p8',
      name: 'Halloween Tote Bag',
      imageUrl: 'assets/images/Halloween.png',
      images: [
        'assets/images/Halloween.png',
      ],
      price: 8.99,
      colors: ['White'],
      sizes: [],
    ),
    'Pen': const Product(
      id: 'p9',
      name: 'UOP Pen',
      imageUrl: 'assets/images/Pen.png',
      images: [
        'assets/images/Pen.png',
      ],
      price: 2.49,
      colors: ['White'],
      sizes: [],
    ),
    'Cap': const Product(
      id: 'p10',
      name: 'UOP Cap',
      imageUrl: 'assets/images/UOP_Cap.png',
      images: [
        'assets/images/UOP_Cap.png',
      ],
      price: 14.99,
      colors: ['Black'],
      sizes: [],
    ),
    'Badge': const Product(
      id: 'p11',
      name: 'Graduation Badge',
      imageUrl: 'assets/images/Badge.png',
      images: [
        'assets/images/Badge.png',
      ],
      price: 1.99,
      colors: ['Multi'],
      sizes: [],
    ),
    'Graduation Capybara': const Product(
      id: 'p12',
      name: 'Graduation Capybara',
      imageUrl: 'assets/images/Graduation.png',
      images: [
        'assets/images/Graduation.png',
      ],
      price: 9.99,
      colors: ['Multi'],
      sizes: [],
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
