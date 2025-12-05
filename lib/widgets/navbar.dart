import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:union_shop/screens/collection.dart';
import 'package:union_shop/screens/sign_in.dart';

class NavBar extends StatefulWidget {
  final String currentRoute;
  final void Function(String route) onNavigate;
  final VoidCallback onSaleTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onAccountTap;
  final VoidCallback? onCartTap;

  const NavBar({
    Key? key,
    this.currentRoute = '/',
    required this.onNavigate,
    required this.onSaleTap,
    this.onSearchTap,
    this.onAccountTap,
    this.onCartTap,
  }) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  static const shopItems = <String, String>{
    'Clothing': '/',
    'Merchandise': '/',
    'Halloween 🎃': '/',
    'Signature & Essential Range': '/',
    'Portsmouth City Collection': '/',
    'Pride Collection 🏳️‍🌈': '/',
    'Graduation 🎓': '/'
  };

  static const printShackItems = <String, String>{
    'About': '/',
    'Personalisation': '/'
  };

  // Mobile dropdown is intentionally removed so you can reimplement
  // a custom menu button and dropdown. The previous _showMobileDropdown
  // logic (showMenu + ExpansionTiles) was removed per your request.

  Widget _buildIcons(BuildContext ctx, double width) {
    const breakpoint = 750;

    if (width < breakpoint) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.search, size: 32, color: Color(0xFF3d4246)),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: widget.onSearchTap ?? () {},
          ),
          IconButton(
              icon: const Icon(Icons.person_outline,
                  size: 32, color: Color(0xFF3d4246)),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: () {
                Navigator.push(
                  ctx,
                  MaterialPageRoute(builder: (_) => const SignIn()),
                );
              }),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined,
                size: 32, color: Color(0xFF3d4246)),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: widget.onCartTap ?? () {},
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.menu, size: 32, color: Color(0xFF3d4246)),
            padding: const EdgeInsets.all(0),
            onSelected: (value) {
              switch (value) {
                case 'home':
                  widget.onNavigate('/');
                  break;
                case 'sale':
                  Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (_) => const CollectionPage(collectionId: 'c2'),
                    ),
                  );
                  break;
                case 'about':
                  widget.onNavigate('/about');
                  break;
                case 'upsu':
                  launchUrl(Uri.parse('https://upsu.net/'));
                  break;
              }
            },
            itemBuilder: (menuCtx) => [
              const PopupMenuItem<String>(value: 'home', child: Text('Home')),
              PopupMenuItem<String>(
                enabled: false,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(menuCtx).size.width - 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ExpansionTile(
                        title: const Text('Shop'),
                        children: shopItems.keys.map((label) {
                          return ListTile(
                            title: Text(label),
                            onTap: () {
                              Navigator.of(menuCtx).pop();
                              final route = shopItems[label]!;
                              widget.onNavigate(route == '/' ? '/' : route);
                            },
                          );
                        }).toList(),
                      ),
                      ExpansionTile(
                        title: const Text('The Print Shack'),
                        children: printShackItems.keys.map((label) {
                          return ListTile(
                            title: Text(label),
                            onTap: () {
                              Navigator.of(menuCtx).pop();
                              final route = printShackItems[label]!;
                              widget.onNavigate(route == '/' ? '/' : route);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const PopupMenuItem<String>(value: 'sale', child: Text('SALE!')),
              const PopupMenuItem<String>(value: 'about', child: Text('About')),
              const PopupMenuItem<String>(
                  value: 'upsu', child: Text('UPSU.net')),
            ],
          ),
        ],
      );
    }

    // Desktop icons
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.search, size: 32, color: Color(0xFF3d4246)),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: widget.onSearchTap ?? () {},
        ),
        IconButton(
          icon: const Icon(Icons.person_outline,
              size: 32, color: Color(0xFF3d4246)),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SignIn()),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined,
              size: 32, color: Color(0xFF3d4246)),
          padding: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          onPressed: widget.onCartTap ?? () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final width = MediaQuery.of(context).size.width;
      const linksVisibleThreshold = 750;
      const double logoMaxWidth = 200.0;
      const double shrinkStart = 470.0;
      const double shrinkEnd = 320.0;
      final logoFactor =
          ((width - shrinkEnd) / (shrinkStart - shrinkEnd)).clamp(0.0, 1.0);
      final logoWidth = logoMaxWidth * logoFactor;

      return Row(
        children: [
          // Logo area (left)
          AnimatedContainer(
            width: logoWidth,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            child: GestureDetector(
              onTap: () => widget.onNavigate('/'),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedOpacity(
                  opacity: logoFactor > 0.05 ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Image(
                    image: const AssetImage('assets/images/upsu.png'),
                    height: 50 * logoFactor.clamp(0.5, 1.0),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // Center links
          if (width >= linksVisibleThreshold)
            Flexible(
              fit: FlexFit.loose,
              child: Center(
                child: Wrap(
                  spacing: 18,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _HoverText(
                      label: 'Home',
                      onTap: () => widget.onNavigate('/'),
                      active: widget.currentRoute == '/',
                    ),
                    _HoverDropdown(
                      label: 'Shop',
                      items: shopItems,
                      onNavigate: (route) => widget.onNavigate(route),
                      active: widget.currentRoute.startsWith('/product') ||
                          widget.currentRoute == '/product',
                    ),
                    _HoverDropdown(
                      label: 'The Print Shack',
                      items: printShackItems,
                      onNavigate: (route) => widget.onNavigate(route),
                      active: false,
                    ),
                    _HoverText(
                        label: 'SALE!',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const CollectionPage(collectionId: 'c2'),
                            ),
                          );
                        }),
                    _HoverText(
                        label: 'About',
                        onTap: () => widget.onNavigate('/about')),
                    _HoverText(
                        label: 'UPSU.net',
                        onTap: () {
                          launchUrl(Uri.parse('https://upsu.net/'));
                        }),
                  ],
                ),
              ),
            )
          else
            const Spacer(),

          // Icons area (right)
          _buildIcons(context, width),
        ],
      );
    });
  }
}

class _HoverText extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool active;

  const _HoverText(
      {required this.label, required this.onTap, this.active = false, Key? key})
      : super(key: key);

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
    final effectiveStyle = const TextStyle(
            color: Colors.black,
            fontFamily: 'Work Sans, sans-serif',
            fontSize: 18,
            fontWeight: FontWeight.w100)
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
  final Map<String, String> items;
  final bool active;
  final void Function(String route) onNavigate;

  const _HoverDropdown(
      {required this.label,
      required this.items,
      required this.onNavigate,
      this.active = false,
      Key? key})
      : super(key: key);

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
              Text(
                widget.label,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Work Sans, sans-serif',
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  decoration: decoration,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.arrow_drop_down, size: 18, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
