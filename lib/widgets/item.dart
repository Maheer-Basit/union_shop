import 'package:flutter/material.dart';
import 'package:union_shop/models/product.dart';

class ProductItemWidget extends StatefulWidget {
  final Product product;
  const ProductItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  late List<String> sizeOptions;
  late List<String> colorOptions;

  String? selectedSize;
  String? selectedColor;
  late String _currentImageUrl;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    debugPrint('ProductItemWidget:initState for ${widget.product.id}');
    _currentImageUrl = widget.product.imageUrl;
    colorOptions = widget.product.colors.isNotEmpty
        ? widget.product.colors
        : ['Red', 'Blue', 'Green'];
    sizeOptions = widget.product.sizes.isNotEmpty
        ? widget.product.sizes
        : ['Small', 'Medium', 'Large'];

    selectedSize = sizeOptions.isNotEmpty ? sizeOptions.first : null;
    selectedColor = colorOptions.isNotEmpty ? colorOptions.first : null;
  }

  Widget _buildImageColumn() {
    final images = widget.product.images;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 4 / 5,
          child: ClipRRect(
            borderRadius: BorderRadius.zero,
            child: Image.asset(
              _currentImageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (images.isNotEmpty) ...[
          const SizedBox(height: 8),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, i) {
                final img = images[i];
                final selected = img == _currentImageUrl;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentImageUrl = img;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selected ? Colors.black : Colors.grey.shade300,
                        width: selected ? 2 : 1,
                      ),
                    ),
                    width: 64,
                    child: ClipRRect(
                      child: Image.asset(img, fit: BoxFit.cover),
                    ),
                  ),
                );
              },
            ),
          ),
        ]
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width > 800 ? 40.0 : 16.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: LayoutBuilder(builder: (ctx, constraints) {
            final isNarrow = constraints.maxWidth < 700;
            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildImageColumn(),
                  const SizedBox(height: 12),
                  ..._buildContent(isNarrow),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 4,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: _buildImageColumn(),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildContent(isNarrow),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  List<Widget> _buildContent(bool isNarrow) {
    return [
      Text(
        widget.product.name,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 8),
      Text(
        '£${widget.product.price.toStringAsFixed(2)}',
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontWeight: FontWeight.w500, color: Colors.black54),
      ),
      const SizedBox(height: 4),
      const Text(
        'Tax included',
        style: TextStyle(fontSize: 12, color: Colors.black54),
      ),
      const SizedBox(height: 18),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Colour', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 6),
                _buildDropdown(colorOptions, selectedColor, (v) {
                  debugPrint(
                      'selectedColor set -> $v for ${widget.product.id}');
                  setState(() => selectedColor = v);
                }),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Size', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 6),
                _buildDropdown(sizeOptions, selectedSize, (v) {
                  debugPrint('selectedSize set -> $v for ${widget.product.id}');
                  setState(() => selectedSize = v);
                }),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quantity', style: TextStyle(fontSize: 14)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                        onPressed: () => setState(() {
                          if (quantity > 1) quantity -= 1;
                        }),
                        icon: const Icon(Icons.remove, size: 20),
                        padding: EdgeInsets.zero,
                        splashRadius: 18,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(quantity.toString(),
                          style: const TextStyle(fontSize: 16)),
                    ),
                    SizedBox(
                      width: 36,
                      height: 36,
                      child: IconButton(
                        onPressed: () => setState(() => quantity += 1),
                        icon: const Icon(Icons.add, size: 20),
                        padding: EdgeInsets.zero,
                        splashRadius: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: const Text('Add to Cart'),
        ),
      ),
      const SizedBox(height: 12),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5433EB),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: const Text('Buy with shop',
              style: TextStyle(color: Colors.white)),
        ),
      ),
      const Center(
        child: Text(
          'More payment options',
          style: TextStyle(
              color: Colors.black54, decoration: TextDecoration.underline),
        ),
      )
    ];
  }

  Widget _buildDropdown(
      List<String> items, String? value, ValueChanged<String?> onChanged) {
    final isEmpty = items.isEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        value: isEmpty ? null : value,
        hint: const Text('Select'),
        items: items
            .map((i) => DropdownMenuItem<String>(value: i, child: Text(i)))
            .toList(),
        onChanged: isEmpty
            ? null
            : (v) {
                onChanged(v);
              },
        underline: const SizedBox.shrink(),
        isDense: true,
        isExpanded: true,
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }
}
