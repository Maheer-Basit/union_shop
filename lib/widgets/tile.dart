import 'package:flutter/material.dart';
import 'package:union_shop/services/product_service.dart';
import 'package:union_shop/models/product.dart';

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
      child: ClipRect(
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
  final String? id;
  final String? image;
  final String? title;
  final String? price;
  final VoidCallback? onTap;
  final double imageHeight;

  const ProductTile({
    Key? key,
    this.id,
    this.image,
    this.title,
    this.price,
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
    final Product? product =
        widget.id != null ? ProductService.getById(widget.id!) : null;
    final displayImage =
        product?.imageUrl ?? widget.image ?? 'assets/images/upsu.png';
    final displayTitle = product?.name ?? widget.title ?? '';
    final displayPrice = product != null
        ? '£${product.price.toStringAsFixed(2)}'
        : (widget.price ?? '');

    return InkWell(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MouseRegion(
            onEnter: _onEnter,
            onExit: _onExit,
            child: ClipRect(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      displayImage,
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
            displayTitle,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            displayPrice,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
