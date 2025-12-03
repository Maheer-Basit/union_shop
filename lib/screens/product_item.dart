import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/item.dart';

class ProductItemPage extends StatelessWidget {
  const ProductItemPage({Key? key}) : super(key: key);

  static const routeName = '/product-item';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MainHeader(currentRoute: ProductItemPage.routeName),
            SizedBox(height: 20),
            ProductItemWidget(),
            SizedBox(height: 32),
            Footer(),
          ],
        ),
      ),
    );
  }
}
