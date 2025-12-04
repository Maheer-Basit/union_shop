import 'package:flutter/material.dart';
import 'package:union_shop/widgets/tile.dart';
import 'package:union_shop/screens/collection.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/services/collections_service.dart';
import 'package:union_shop/models/collections.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final cross = width > 800 ? 3 : (width > 600 ? 2 : 1);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MainHeader(
              currentRoute: '/collections',
              onNavigate: (route) => Navigator.pushNamed(context, route),
              onSaleTap: () => Navigator.pushNamed(context, '/sale'),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Text(
                  'Collections',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3d4246),
                    fontFamily: 'WorkSans',
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            FutureBuilder<List<Collections>>(
              future: CollectionsService().fetchAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 220,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final cols = snapshot.data ?? [];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 220, vertical: 12),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: cross,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25,
                    childAspectRatio: 0.75,
                    children: cols.map((c) {
                      return CollectionTile(
                        image: c.imageUrl,
                        title: c.title,
                        height: 100,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    CollectionPage(collectionId: c.id)),
                          );
                        },
                      );
                    }).toList(),
                  ),
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
