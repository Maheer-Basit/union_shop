import 'package:flutter/material.dart';

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

      if (constraints.maxWidth < 600) {
        return const SizedBox.shrink();
      }

      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth:
                  constraints.maxWidth > 1000 ? 800 : constraints.maxWidth),
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            children: [
              hoverableText('Home',
                  onTap: () => widget.onNavigate('/'),
                  active: widget.currentRoute == '/'),
              _HoverDropdown(
                label: 'Shop',
                active: widget.currentRoute == '/product',
                items: const {
                  'Clothing': '/',
                  'Merchandise': '/',
                  'Halloween': '/',
                  'Signature & Essential Range': '/',
                  'Portsmouth City Collection': '/',
                  'Pride Collection': '/',
                  'Graduation': '/'
                },
                onNavigate: (route) => widget.onNavigate(route),
              ),
              _HoverDropdown(
                label: 'The Print Shack',
                items: const {'About': '/', 'Personalisation': '/'},
                onNavigate: (route) => widget.onNavigate(route),
              ),
              hoverableText('SALE!', onTap: widget.onSaleTap),
              hoverableText('About' , 
              onTap: () => widget.onNavigate('/about'),
              active: widget.currentRoute == '/about'),
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
