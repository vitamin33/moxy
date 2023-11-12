import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ScrollableSection extends StatelessWidget {
  final Widget content;
  const ScrollableSection({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:const EdgeInsets.symmetric(horizontal: AppTheme.chekoutPadding),
        child: content,
      ),
    );
  }
}
