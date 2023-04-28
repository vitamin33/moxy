import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class RoundedCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;

  const RoundedCard({
    Key? key,
    required this.child,
    this.title,
    this.padding,
    this.margin,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return Container(
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          gradient: color != null
              ? null
              : const RadialGradient(
                  radius: 1.5,
                  colors: [
                    AppTheme.primaryContainerColor,
                    AppTheme.surfaceColor,
                  ],
                ),
          borderRadius: BorderRadius.circular(8),
          color: color ?? Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 8,
            ),
          ],
        ),
        child: child,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        if (title != null) const SizedBox(height: AppTheme.elementSpacing),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 6,
                ),
              ],
            ),
            child: 
            child),
      ],
    );
  }
}
