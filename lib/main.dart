import 'package:flutter/material.dart';
import 'package:union_shop/product_page.dart';

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

class NavBar extends StatefulWidget {
  final String currentRoute;
  final void Function(String route) onNavigate;
  final VoidCallback onSaleTap;

  const NavBar({
    required this.currentRoute,
    required this.onNavigate,
    required this.onSaleTap,
    super.key,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    Widget hoverableText(String label,
        {required VoidCallback onTap, bool active = false, TextStyle? style}) {
      return _HoverText(
        label: label,
        active: active,
        style: style,
        onTap: onTap,
      );
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth:
                  constraints.maxWidth > 1000 ? 800 : constraints.maxWidth),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            children: [
              hoverableText('Home',
                  onTap: () => widget.onNavigate('/'),
                  active: widget.currentRoute == '/'),
              _HoverDropdown(
                label: 'Shop',
                active: widget.currentRoute == '/product',
                items: const {'Clothing': '/', 'Merchandise': '/', 'Halloween': '/', 
                'Signature & Essential Range': '/', 'Portsmouth City Collection': '/',
                 'Pride Collection': '/', 'Graduation': '/'},
                onNavigate: (route) => widget.onNavigate(route),
              ),
              _HoverDropdown(
                label: 'The Print Shack',
                items: const {'About': '/', 'Personalisation': '/'},
                onNavigate: (route) => widget.onNavigate(route),
              ),
              hoverableText('SALE!',
                  onTap: widget.onSaleTap),
              hoverableText('About', onTap: () {}),
              hoverableText('UPSU.net', onTap: () {}),
            ],
          ),
        ),
      );
    });
  }
}

class _HoverText extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool active;
  final TextStyle? style;

  const _HoverText(
      {required this.label,
      required this.onTap,
      this.active = false,
      this.style,
      super.key});

  @override
  State<_HoverText> createState() => _HoverTextState();
}

class _HoverTextState extends State<_HoverText> {
  bool _hover = false;

  void _handleTap() => widget.onTap();

  @override
  Widget build(BuildContext context) {
    final decoration = widget.active || _hover
        ? TextDecoration.underline
        : TextDecoration.none;
    final effectiveStyle =
        (widget.style ?? const TextStyle(color: Colors.black, 
        fontFamily: 'Work Sans, sans-serif', fontSize: 18, fontWeight: FontWeight.w100))
            .copyWith(decoration: decoration);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: _handleTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
          child: Text(widget.label, style: effectiveStyle),
        ),
      ),
    );
  }
}

class _HoverDropdown extends StatefulWidget {
  final String label;
  final Map<String, String> items; // label -> route
  final bool active;
  final void Function(String route) onNavigate;

  const _HoverDropdown(
      {required this.label,
      required this.items,
      required this.onNavigate,
      this.active = false,
      super.key});

  @override
  State<_HoverDropdown> createState() => _HoverDropdownState();
}

class _HoverDropdownState extends State<_HoverDropdown> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final decoration = widget.active || _hover
        ? TextDecoration.underline
        : TextDecoration.none;

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: PopupMenuButton<int>(
        onSelected: (index) {
          final route = widget.items.values.elementAt(index);
          widget.onNavigate(route);
        },
        itemBuilder: (ctx) => List<PopupMenuEntry<int>>.generate(
          widget.items.length,
          (i) => PopupMenuItem<int>(
              value: i, child: Text(widget.items.keys.elementAt(i))),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label,
                  style:
                      const TextStyle(color: Colors.black, 
        fontFamily: 'Work Sans, sans-serif', fontSize: 18, fontWeight: FontWeight.w300)),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 18, color: Colors.black),
            ],
          ),
        ),
      ),
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
              height: 120,
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
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              navigateToHome(context);
                            },
                            child: Image.network(
                              'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  width: 40,
                                  height: 40,
                                  child: const Center(
                                    child: Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                                  ),
                                );
                              },
                            ),
                          ),
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
                                    size: 18,
                                    color: Colors.grey,
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
                                    size: 18,
                                    color: Colors.grey,
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
                                    size: 18,
                                    color: Colors.grey,
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
                                    Icons.menu,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  constraints: const BoxConstraints(
                                    minWidth: 32,
                                    minHeight: 32,
                                  ),
                                  onPressed: placeholderCallbackForButtons,
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
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ),
                  // Content overlay
                  Positioned(
                    left: 24,
                    right: 24,
                    top: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Placeholder Hero Title',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "This is placeholder text for the hero section.",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: placeholderCallbackForButtons,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            'BROWSE PRODUCTS',
                            style: TextStyle(fontSize: 14, letterSpacing: 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

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
            Container(
              width: double.infinity,
              color: Colors.grey[50],
              padding: const EdgeInsets.all(24),
              child: const Text(
                'Placeholder Footer',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
