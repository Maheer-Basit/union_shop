import 'package:flutter/material.dart';
import 'package:union_shop/widgets/tile.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(
        6,
        (i) => {
              'title': 'Collection ${i + 1}',
              'image': 'assets/images/UOP_T_Shirt.png',
            });

    final width = MediaQuery.of(context).size.width;
    final cross = width > 800 ? 3 : (width > 600 ? 2 : 1);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          NavBar(
            currentRoute: '/collections',
            onNavigate: (route) => Navigator.pushNamed(context, route),
            onSaleTap: () => Navigator.pushNamed(context, '/sale'),
          ),
          // moved page title below the navbar
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
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 220, vertical: 12),
              child: GridView.count(
                crossAxisCount: cross,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                childAspectRatio: 0.75,
                children: items.map((m) {
                  return CollectionTile(
                    image: m['image']!,
                    title: m['title']!,
                    height: 100,
                    onTap: () {
                      Navigator.pushNamed(context, '/winter-favourites');
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          // footer at the bottom
          const Footer(),
        ],
      ),
    );
  }
}
