import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/tile.dart';
import 'package:union_shop/widgets/filter.dart';
import 'package:union_shop/widgets/footer.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeader(
              currentRoute: '/sale',
              onNavigate: (route) => Navigator.pushNamed(context, route),
              onSaleTap: () => Navigator.pushNamed(context, '/sale'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text(
                  'Sale',
                  style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3d4246)),
                ),
              ),
            ),
            Builder(builder: (ctx) {
              final width = MediaQuery.of(ctx).size.width;
              final cross = width > 800 ? 3 : (width > 600 ? 2 : 1);
              final sidePadding =
                  width > 1200 ? 120.0 : (width > 800 ? 64.0 : 28.0);
              final items = List.generate(
                6,
                (i) => {
                  'title': 'Sale Product ${i + 1}',
                  'image': 'assets/images/UOP_T_Shirt.png',
                  'price': '£${(10 + i * 3).toString()}.00'
                },
              );

              return Column(
                children: [
                  FilterBar(
                    totalProducts: items.length,
                    filters: const ['All', 'Clothing', 'Accessories'],
                    sorts: const [
                      'Relevance',
                      'Price: Low to High',
                      'Price: High to Low'
                    ],
                    filterValue: 'All',
                    sortValue: 'Relevance',
                    onFilterChanged: (v) {},
                    onSortChanged: (v) {},
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: sidePadding, vertical: 12),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: cross,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.8,
                      children: items.map((m) {
                        final id = (m['id'] as String?) ??
                            (m['title'] as String?) ??
                            'p1';
                        return ProductTile(
                          image: m['image']!,
                          title: m['title']!,
                          price: m['price']!,
                          onTap: () => Navigator.pushNamed(ctx, '/product-item',
                              arguments: id),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
