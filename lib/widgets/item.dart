import 'package:flutter/material.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({Key? key}) : super(key: key);

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  final List<String> sizeOptions = ['Small', 'Medium', 'Large'];
  final List<String> colorOptions = ['Red', 'Blue', 'Green'];

  String? selectedSize;
  String? selectedColor;
  final TextEditingController customTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedSize = sizeOptions.first;
    selectedColor = colorOptions.first;
  }

  @override
  void dispose() {
    customTextController.dispose();
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
            return isNarrow
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _buildContent(isNarrow),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: AspectRatio(
                            aspectRatio: 4 / 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.zero,
                              child: Image.asset(
                                'assets/images/UOP_Jacket.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
        'Classic University Jacket',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 8),
      Text(
        '£11.50',
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
                TextField(
                  controller: customTextController,
                  decoration: const InputDecoration(
                    hintText: '1',
                    border: OutlineInputBorder(borderRadius: BorderRadius.zero),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  ),
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
          style: TextStyle(color: Colors.black54, decoration: TextDecoration.underline),
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
        value: isEmpty ? null : value ?? items.first,
        items: items
            .map((i) => DropdownMenuItem<String>(value: i, child: Text(i)))
            .toList(),
        onChanged: isEmpty ? null : onChanged,
        underline: const SizedBox.shrink(),
        isDense: true,
        isExpanded: true,
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }
}
