import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/widgets/mainheader.dart';
import 'package:union_shop/widgets/footer.dart';
import 'package:union_shop/widgets/hero_section.dart';
import 'package:union_shop/widgets/products_section.dart';
import 'package:union_shop/screens/about_page.dart';
import 'package:union_shop/screens/collections_page.dart';
import 'package:union_shop/screens/winter_favourites.dart';
import 'package:union_shop/screens/sign_in.dart';
import 'package:union_shop/screens/sale.dart';
import 'package:union_shop/screens/product_item.dart';

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
        '/sign-in': (context) => const SignIn(),
        '/sale': (context) => const SalePage(),
        '/product-item': (context) => const ProductItemPage(),
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
            Builder(builder: (ctx) {
              return MainHeader(
                currentRoute: ModalRoute.of(ctx)?.settings.name ?? '/',
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
