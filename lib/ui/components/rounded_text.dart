import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class RoundedText extends StatelessWidget {
  final int number;
  final Color borderColor;
  final double size;
  final double borderWidth;

  const RoundedText({
    super.key,
    required this.number,
    this.borderColor = AppTheme.textColor,
    this.size = 30,
    this.borderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(
            fontSize: size * 0.4,
            fontWeight: FontWeight.bold,
            color: borderColor,
          ),
        ),
      ),
    );
  }
}
