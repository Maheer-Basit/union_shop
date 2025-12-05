import 'package:flutter/material.dart';

class PrintCustomizer extends StatefulWidget {
  final String title;
  final double price;
  final List<String> images;

  const PrintCustomizer({
    Key? key,
    required this.title,
    required this.price,
    required this.images,
  }) : super(key: key);

  @override
  State<PrintCustomizer> createState() => _PrintCustomizerState();
}

class _PrintCustomizerState extends State<PrintCustomizer> {
  late String currentImage;
  String perLineOption = 'One Line Of Text';
  final List<String> perLineOptions = ['One Line Of Text', 'Two Lines'];
  final TextEditingController personalisationController =
      TextEditingController();
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    currentImage = widget.images.isNotEmpty
        ? widget.images.first
        : 'assets/images/UOP_Hoodie.png';
  }

  @override
  void dispose() {
    personalisationController.dispose();
    super.dispose();
  }

  void _decrement() {
    setState(() {
      if (quantity > 1) quantity -= 1;
    });
  }

  void _increment() {
    setState(() {
      quantity += 1;
    });
  }

  Widget _buildImageColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Container(
              color: Colors.grey[200],
              child: Image.asset(currentImage, fit: BoxFit.cover),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (widget.images.isNotEmpty)
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, i) {
                final img = widget.images[i];
                final selected = img == currentImage;
                return GestureDetector(
                  onTap: () => setState(() => currentImage = img),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: selected ? Colors.black : Colors.grey.shade300,
                          width: selected ? 2 : 1),
                    ),
                    width: 64,
                    child: Image.asset(img, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildRightColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text('£${widget.price.toStringAsFixed(2)}',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w500, color: Colors.black87)),
        const SizedBox(height: 4),
        const Text('Tax included',
            style: TextStyle(fontSize: 12, color: Colors.black54)),
        const SizedBox(height: 18),
        const Text('Per Line: One Line Of Text',
            style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            value: perLineOption,
            items: perLineOptions
                .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                .toList(),
            onChanged: (v) =>
                setState(() => perLineOption = v ?? perLineOption),
            underline: const SizedBox.shrink(),
            isExpanded: true,
          ),
        ),
        const SizedBox(height: 16),
        const Text('Personalisation Line 1:', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: personalisationController,
          decoration: const InputDecoration(
            hintText: 'Enter text to print',
            border: OutlineInputBorder(borderRadius: BorderRadius.zero),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Quantity', style: TextStyle(fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: _decrement,
                icon: const Icon(Icons.remove),
                splashRadius: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300)),
              child: Text(quantity.toString(),
                  style: const TextStyle(fontSize: 16)),
            ),
            IconButton(
                onPressed: _increment,
                icon: const Icon(Icons.add),
                splashRadius: 20),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final personalization = personalisationController.text;
              debugPrint(
                  'Add to cart: ${widget.title} x$quantity — "$personalization" — $perLineOption');
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart (demo)')));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5433EB),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            child: const Text('Add to Cart',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding = width > 800 ? 40.0 : 16.0;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1100),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
          child: LayoutBuilder(builder: (ctx, constraints) {
            final isNarrow = constraints.maxWidth < 700;

            if (isNarrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildImageColumn(),
                  const SizedBox(height: 12),
                  _buildRightColumn(context),
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
                        child: _buildImageColumn())),
                const SizedBox(width: 24),
                Expanded(flex: 7, child: _buildRightColumn(context)),
              ],
            );
          }),
        ),
      ),
    );
  }
}
