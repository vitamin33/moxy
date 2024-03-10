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
    final theme = AppTheme.of(context)!;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppTheme.black)),
      padding: const EdgeInsets.all(1),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: () {
                onMinus();
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.remove, size: 24),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              '$quantity',
              style: theme.mediumText,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: () {
                onPlus();
              },
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.add, size: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
