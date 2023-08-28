import 'package:flutter/material.dart';

class ScrollableSection extends StatelessWidget {
  final Widget content;
  const ScrollableSection({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: content,
    );
  }
}
