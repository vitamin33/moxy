import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPromo extends StatelessWidget {
  const ShimmerPromo({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    final itemPadding = isMobile ? 16.0 : 24.0;

    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: Padding(
        padding: isMobile
            ? EdgeInsets.symmetric(
                horizontal: itemPadding,
                vertical: AppTheme.defaultPadding,
              )
            : EdgeInsets.all(itemPadding),
        child: Container(
          color: AppTheme.white,
          height: 350,
        ),
      ),
    );
  }
}
