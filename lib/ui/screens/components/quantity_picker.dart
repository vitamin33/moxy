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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                onMinus();
              },
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.remove,
                ),
              ),
            ),
          ),
          Flexible(
            child: Text(
              '$quantity',
              style: theme.mediumText,
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                onPlus();
              },
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.add,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
