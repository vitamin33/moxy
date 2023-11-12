import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class QuantityPicker extends StatelessWidget {
  final int quantity;
  final ValueGetter onPlus;
  final ValueGetter onMinus;

  const QuantityPicker({
    super.key,
    required this.quantity,
    required this.onPlus,
    required this.onMinus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppTheme.black)),
      padding: const EdgeInsets.all(1),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              onMinus();
            },
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.remove),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '$quantity',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: () {
              onPlus();
            },
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
