import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/navbar.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/hero_section.dart';
import 'package:union_shop/widgets/products_section.dart';
import 'package:union_shop/screens/about_page.dart';
import 'package:union_shop/screens/collections_page.dart';
import 'package:union_shop/screens/winter_favourites.dart';

void main() {
  runApp(const UnionShopApp());
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
      ),
      home: const HomeScreen(),
      // By default, the app starts at the '/' route, which is the HomeScreen
      initialRoute: '/',
      routes: {
        '/product': (context) => const ProductPage(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/winter-favourites': (context) => const WinterFavourites(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  void navigateToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  void navigateToAbout(BuildContext context) {
    Navigator.pushNamed(context, '/about');
  }

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              constraints: const BoxConstraints(minHeight: 80, maxHeight: 140),
              color: Colors.white,
              child: Column(
                children: [
                  // Top banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    color: const Color(0xFF4d2963),
                    child: const Text(
                      'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF! COME GRAB YOURS WHILE STOCK LASTS!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Work Sans, sans-serif',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  // Main header
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width > 800
                              ? 40
                              : 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Builder(builder: (ctx) {
                              final current =
                                  ModalRoute.of(ctx)?.settings.name ?? '/';
                              return NavBar(
                                currentRoute: current,
                                onNavigate: (route) {
                                  if (route == '/') {
                                    navigateToHome(ctx);
                                  } else {
                                    Navigator.pushNamed(ctx, route);
                                  }
                                },
                                onSaleTap: placeholderCallbackForButtons,
                                onSearchTap: placeholderCallbackForButtons,
                                onAccountTap: placeholderCallbackForButtons,
                                onCartTap: placeholderCallbackForButtons,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Hero Section
            HeroSection(onBrowse: placeholderCallbackForButtons),

            // Products Section
            const ProductsSection(),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}
