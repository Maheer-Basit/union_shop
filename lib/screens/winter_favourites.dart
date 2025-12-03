import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/tile.dart';
import 'package:union_shop/widgets/filter.dart';
import 'package:union_shop/widgets/footer.dart';

class WinterFavourites extends StatelessWidget {
  const WinterFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeader(
              currentRoute: '/winter-favourites',
              onNavigate: (route) => Navigator.pushNamed(context, route),
              onSaleTap: () => Navigator.pushNamed(context, '/sale'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Winter Favourites',
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF3d4246),
                          fontFamily: 'Work Sans',
                          letterSpacing: 1.2),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Shop all of this seasons must haves in one place!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Color(0xFF5a5f63)),
                    ),
                  ],
                ),
              ),
            ),
            Builder(builder: (ctx) {
              final width = MediaQuery.of(ctx).size.width;
              final cross = width > 800 ? 3 : (width > 600 ? 2 : 1);
              final items = List.generate(
                  6,
                  (i) => {
                        'title': 'Product ${i + 1}',
                        'image': 'assets/images/UOP_Jacket.png',
                        'price': '£${(20 + i * 5).toString()}.00'
                      });

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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: cross,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.65,
                      children: items.map((m) {
                        return ProductTile(
                          image: m['image']!,
                          title: m['title']!,
                          price: m['price']!,
                          onTap: () => Navigator.pushNamed(ctx, '/product'),
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
