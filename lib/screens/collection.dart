import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/tile.dart';
import 'package:union_shop/widgets/filter.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/services/collections_service.dart';
import 'package:union_shop/models/collections.dart';

class CollectionPage extends StatelessWidget {
  final String collectionId;
  const CollectionPage({Key? key, required this.collectionId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeader(
              currentRoute: '/collections',
              onNavigate: (route) => Navigator.pushNamed(context, route),
              onSaleTap: () => Navigator.pushNamed(context, '/sale'),
            ),
            FutureBuilder<Collections?>(
              future: CollectionsService().fetchById(collectionId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: SizedBox(
                        height: 180,
                        child: Center(child: CircularProgressIndicator())),
                  );
                }

                final collection = snapshot.data;
                if (collection == null) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(child: Text('Collection not found')),
                  );
                }

                // Header/title area (keeps same styling as WinterFavourites)
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              collection.title,
                              style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3d4246),
                                  fontFamily: 'Work Sans',
                                  letterSpacing: 1.2),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Shop all of this seasons must haves in one place!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF5a5f63)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Products grid for this collection
                    Builder(builder: (ctx) {
                      final width = MediaQuery.of(ctx).size.width;
                      final cross = width > 800 ? 3 : (width > 600 ? 2 : 1);
                      final sidePadding =
                          width > 1200 ? 120.0 : (width > 800 ? 64.0 : 28.0);

                      final productIds = collection.productIds;

                      return Column(
                        children: [
                          FilterBar(
                            totalProducts: productIds.length,
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
                              children: productIds.map((pid) {
                                return ProductTile(
                                  id: pid,
                                  onTap: () => Navigator.pushNamed(
                                      ctx, '/product-item',
                                      arguments: pid),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                );
              },
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
