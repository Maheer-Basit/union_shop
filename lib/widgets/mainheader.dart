import 'package:flutter/material.dart';
import 'package:union_shop/widgets/navbar.dart';

class MainHeader extends StatelessWidget {
  final String currentRoute;
  final void Function(String)? onNavigate;
  final VoidCallback? onSaleTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onAccountTap;
  final VoidCallback? onCartTap;

  const MainHeader({
    super.key,
    this.currentRoute = '/',
    this.onNavigate,
    this.onSaleTap,
    this.onSearchTap,
    this.onAccountTap,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  fontWeight: FontWeight.w600),
            ),
          ),
          // Main header with NavBar
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.of(context).size.width > 800 ? 40 : 16),
              child: Row(
                children: [
                  Expanded(
                    child: NavBar(
                      currentRoute: currentRoute,
                      onNavigate: onNavigate ??
                          (route) {
                            if (route == '/') {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (r) => false);
                            } else {
                              Navigator.pushNamed(context, route);
                            }
                          },
                      onSaleTap: onSaleTap ??
                          () => Navigator.pushNamed(context, '/sale'),
                      onSearchTap: onSearchTap,
                      onAccountTap: onAccountTap,
                      onCartTap: onCartTap,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
