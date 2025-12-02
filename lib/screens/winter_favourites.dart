import 'package:flutter/material.dart';
import 'package:union_shop/widgets/mainheader.dart';

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
              padding: EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  'Winter Favourites',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
