import 'package:flutter/material.dart';
import 'package:union_shop/services/product_service.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            const Text(
              'ESSENTIAL RANGE - OVER 20% OFF!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 48),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 48,
              children: const [
                ProductCard(id: 'p1'),
                ProductCard(id: 'p5'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Signature Range',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
              crossAxisSpacing: 24,
              mainAxisSpacing: 48,
              children: const [
                ProductCard(id: 'p3'),
                ProductCard(id: 'p4'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String id;

  const ProductCard({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = ProductService.getById(id);
    final displayImage = product?.imageUrl ?? '';
    final displayTitle = product?.name ?? '';
    final displayPrice =
        product != null ? '£${product.price.toStringAsFixed(2)}' : '';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product-item', arguments: id);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              displayImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                displayTitle,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                displayPrice,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
