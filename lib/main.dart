import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';
import 'package:union_shop/models/navbar.dart';
import 'package:union_shop/models/footer.dart';
import 'package:union_shop/models/hero_section.dart';

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
      // When navigating to '/product', build and return the ProductPage
      // In your browser, try this link: http://localhost:49856/#/product
      routes: {'/product': (context) => const ProductPage()},
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
                          Builder(builder: (logoCtx) {
                            final width = MediaQuery.of(logoCtx).size.width;
                            const double minWidth =
                                160; // when logo becomes invisible
                            const double fullWidth =
                                600; // width where logo is full size
                            const double maxLogoHeight = 40;

                            // Linear interpolation from minWidth..fullWidth -> 0..maxLogoHeight
                            final double t =
                                (width - minWidth) / (fullWidth - minWidth);
                            final double clamped = t < 0 ? 0 : (t > 1 ? 1 : t);
                            final double logoHeight = clamped * maxLogoHeight;

                            // When the logo is effectively zero-sized, don't render it at all
                            if (logoHeight <= 1) return const SizedBox.shrink();

                            return GestureDetector(
                              onTap: () {
                                navigateToHome(logoCtx);
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                height: logoHeight,
                                curve: Curves.easeInOut,
                                child: Center(
                                  child: Image.network(
                                    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                                    height: logoHeight,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        width: logoHeight,
                                        height: logoHeight,
                                        child: const Center(
                                          child: Icon(Icons.image_not_supported,
                                              color: Colors.grey),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
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
                              );
                            }),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.search,
                                    size: 32,
                                    color: Color(0xFF3d4246),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.person_outline,
                                    size: 32,
                                    color: Color(0xFF3d4246),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 32,
                                    color: Color(0xFF3d4246),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
                                ),
                                if (MediaQuery.of(context).size.width < 600)
                                  IconButton(
                                    icon: const Icon(
                                      Icons.menu,
                                      size: 32,
                                      color: Color(0xFF3d4246),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    constraints: const BoxConstraints(
                                      minWidth: 32,
                                      minHeight: 32,
                                    ),
                                    onPressed: () {
                                      const shopItems = const <String, String>{
                                        'Clothing': '/',
                                        'Merchandise': '/',
                                        'Halloween 🎃': '/',
                                        'Signature & Essential Range': '/',
                                        'Portsmouth City Collection': '/',
                                        'Pride Collection 🏳️‍🌈': '/',
                                        'Graduation 🎓': '/'
                                      };
                                      const printShackItems = <String, String>{
                                        'About': '/',
                                        'Personalisation': '/'
                                      };

                                      showModalBottomSheet<void>(
                                        context: context,
                                        builder: (ctx) {
                                          return SafeArea(
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ListTile(
                                                    title: const Text('Home'),
                                                    onTap: () {
                                                      Navigator.pop(ctx);
                                                      navigateToHome(context);
                                                    },
                                                  ),
                                                  ExpansionTile(
                                                    title: const Text('Shop'),
                                                    children: shopItems.keys
                                                        .map((label) {
                                                      return ListTile(
                                                        title: Text(label),
                                                        onTap: () {
                                                          Navigator.pop(ctx);
                                                          final route =
                                                              shopItems[label]!;
                                                          if (route == '/') {
                                                            navigateToHome(
                                                                context);
                                                          } else {
                                                            Navigator.pushNamed(
                                                                context, route);
                                                          }
                                                        },
                                                      );
                                                    }).toList(),
                                                  ),
                                                  ExpansionTile(
                                                    title: const Text(
                                                        'The Print Shack'),
                                                    children: printShackItems
                                                        .keys
                                                        .map((label) {
                                                      return ListTile(
                                                        title: Text(label),
                                                        onTap: () {
                                                          Navigator.pop(ctx);
                                                          final route =
                                                              printShackItems[
                                                                  label]!;
                                                          if (route == '/') {
                                                            navigateToHome(
                                                                context);
                                                          } else {
                                                            Navigator.pushNamed(
                                                                context, route);
                                                          }
                                                        },
                                                      );
                                                    }).toList(),
                                                  ),
                                                  ListTile(
                                                    title: const Text('SALE!',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                    onTap: () {
                                                      Navigator.pop(ctx);
                                                      placeholderCallbackForButtons();
                                                    },
                                                  ),
                                                  ListTile(
                                                    title: const Text('About'),
                                                    onTap: () {
                                                      Navigator.pop(ctx);
                                                      // placeholder
                                                    },
                                                  ),
                                                  ListTile(
                                                    title:
                                                        const Text('UPSU.net'),
                                                    onTap: () {
                                                      Navigator.pop(ctx);
                                                      // placeholder external link
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                              ],
                            ),
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
            Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    const Text(
                      'PRODUCTS SECTION',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 48),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 48,
                      children: const [
                        ProductCard(
                          title: 'Placeholder Product 1',
                          price: '£10.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        ),
                        ProductCard(
                          title: 'Placeholder Product 2',
                          price: '£15.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        ),
                        ProductCard(
                          title: 'Placeholder Product 3',
                          price: '£20.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        ),
                        ProductCard(
                          title: 'Placeholder Product 4',
                          price: '£25.00',
                          imageUrl:
                              'https://shop.upsu.net/cdn/shop/files/PortsmouthCityMagnet1_1024x1024@2x.jpg?v=1752230282',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// (old scaffolded NavBar and material-style helper removed)
