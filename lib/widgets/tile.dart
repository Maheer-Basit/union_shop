import 'package:flutter/material.dart';

class CollectionTile extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback? onTap;
  final double height;
  const CollectionTile({
    Key? key,
    required this.image,
    required this.title,
    this.onTap,
    this.height = 160,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        child: SizedBox(
          height: height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              Container(color: Colors.black.withOpacity(0.45)),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback? onTap;
  final double imageHeight;

  const ProductTile({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    this.onTap,
    this.imageHeight = 140,
  }) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool _hovering = false;

  void _onEnter(PointerEvent _) {
    setState(() {
      _hovering = true;
    });
  }

  void _onExit(PointerEvent _) {
    setState(() {
      _hovering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
 
          MouseRegion(
            onEnter: _onEnter,
            onExit: _onExit,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                   
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      color: _hovering
                          ? Colors.white.withOpacity(0.45)
                          : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            widget.price,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
