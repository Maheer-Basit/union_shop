import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  final int totalProducts;
  final List<String> filters;
  final List<String> sorts;
  final String? filterValue;
  final String? sortValue;
  final ValueChanged<String?>? onFilterChanged;
  final ValueChanged<String?>? onSortChanged;

  const FilterBar({
    Key? key,
    required this.totalProducts,
    required this.filters,
    required this.sorts,
    this.filterValue,
    this.sortValue,
    this.onFilterChanged,
    this.onSortChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.grey.shade300;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: borderColor, width: 1),
          bottom: BorderSide(color: borderColor, width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Left side: filter/sort controls
          Expanded(
            child: Row(
              children: [
                const Text('Filter by', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                _buildDropdown(filters, filterValue, onFilterChanged),
                const SizedBox(width: 20),
                const Text('Sort by', style: TextStyle(fontSize: 14)),
                const SizedBox(width: 8),
                _buildDropdown(sorts, sortValue, onSortChanged),
              ],
            ),
          ),

          // Right side: total products
          Text(
            '$totalProducts products',
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
      List<String> items, String? value, ValueChanged<String?>? onChanged) {
    final isEmpty = items.isEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.grey.shade200),
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
        style: const TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }
}
