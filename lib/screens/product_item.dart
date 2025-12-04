import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/item.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/models/product.dart';

class ProductItemPage extends StatefulWidget {
  const ProductItemPage({Key? key}) : super(key: key);

  static const routeName = '/product-item';

  @override
  State<ProductItemPage> createState() => _ProductItemPageState();
}

class _ProductItemPageState extends State<ProductItemPage> {
  late final ProductService _service;
  late Future<Product?> _future;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      final args = ModalRoute.of(context)?.settings.arguments;
      String id = 'p1';
      if (args is String) {
        id = args;
      } else if (args is Map && args['id'] is String) {
        id = args['id'] as String;
      }

      _service = ProductService();
      _future = _service.fetchById(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const MainHeader(currentRoute: ProductItemPage.routeName),
            const SizedBox(height: 20),
            FutureBuilder<Product?>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: Text('Product not found')),
                  );
                }

                final product = snapshot.data!;

                return ProductItemWidget(
                    key: ValueKey(product.id), product: product);
              },
            ),
            const SizedBox(height: 32),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
