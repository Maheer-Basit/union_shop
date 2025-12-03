import 'package:flutter/material.dart';

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

  void _openMobileMenu(BuildContext ctx) {
    showModalBottomSheet<void>(
      context: ctx,
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
                    widget.onNavigate('/');
                  },
                ),
                ExpansionTile(
                  title: const Text('Shop'),
                  children: shopItems.keys.map((label) {
                    return ListTile(
                      title: Text(label),
                      onTap: () {
                        Navigator.pop(ctx);
                        final route = shopItems[label]!;
                        if (route == '/') {
                          widget.onNavigate('/');
                        } else {
                          widget.onNavigate(route);
                        }
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
                        Navigator.pop(ctx);
                        final route = printShackItems[label]!;
                        if (route == '/') {
                          widget.onNavigate('/');
                        } else {
                          widget.onNavigate(route);
                        }
                      },
                    );
                  }).toList(),
                ),
                ListTile(
                  title: const Text('SALE!',
                      style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.onSaleTap();
                  },
                ),
                ListTile(
                  title: const Text('About'),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.onNavigate('/about');
                  },
                ),
                ListTile(
                  title: const Text('UPSU.net'),
                  onTap: () {
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
              Navigator.pushNamed(ctx, '/sign-in');
            }
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined,
                size: 32, color: Color(0xFF3d4246)),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: widget.onCartTap ?? () {},
          ),

          IconButton(
            icon: const Icon(Icons.menu, size: 32, color: Color(0xFF3d4246)),
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: () => _openMobileMenu(ctx),
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
          onPressed: widget.onAccountTap ?? () {},
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
      const breakpoint = 750;
      return Row(
        children: [
          // Logo area (left)
          SizedBox(
            width: 200,
            child: GestureDetector(
              onTap: () => widget.onNavigate('/'),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Image(
                  image: AssetImage('assets/images/upsu.png'),
                  height: 50,
                ),
            ),
          ),
          ),

          // Center links (hidden on narrow screens)
          if (width >= breakpoint)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
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
                  _HoverText(label: 'SALE!', onTap: () => widget.onNavigate('/sale')),
                  _HoverText(
                      label: 'About', onTap: () => widget.onNavigate('/about')),
                  _HoverText(label: 'UPSU.net', onTap: () {}),
                ],
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
  final TextStyle? style;

  const _HoverText(
      {required this.label,
      required this.onTap,
      this.active = false,
      this.style,
      Key? key})
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
    final effectiveStyle = (widget.style ??
            const TextStyle(
                color: Colors.black,
                fontFamily: 'Work Sans, sans-serif',
                fontSize: 18,
                fontWeight: FontWeight.w100))
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
