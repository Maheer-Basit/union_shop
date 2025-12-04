import 'package:union_shop/models/product.dart';

class ProductService {
  static final _items = <String, Product>{
    'p1': const Product(
      id: 'p1',
      name: 'Classic T-Shirt',
      imageUrl: 'assets/images/UOP_T_Shirt.png',
      images: [
        'assets/images/UOP_T_Shirt.png',
        'assets/images/UOP_Jacket.png',
      ],
      price: 19.99,
      colors: ['White', 'Black', 'Blue'],
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    'p2': const Product(
      id: 'p2',
      name: 'Hoodie',
      imageUrl: 'assets/images/UOP_Hoodie.png',
      images: [
        'assets/images/UOP_Hoodie.png',
        'assets/images/UOP_Jacket.png',
      ],
      price: 39.99,
      colors: ['Grey', 'Black'],
      sizes: ['M', 'L', 'XL'],
    ),
    'p3': const Product(
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
  };
  Future<Product?> fetchById(String id) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _items[id];
  }
}
