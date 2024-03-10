import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = ResponsiveUtil.isMobile(context);

    double cardWidth = isMobile ? screenWidth - 40 : 330;
    double cardHeight = isMobile ? 300 : 340;
    double itemPadding = isMobile ? 16 : 16;

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
            width: cardWidth,
            height: cardHeight,
          ),
        ));
  }
}
