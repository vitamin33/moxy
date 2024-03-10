import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageCarusel extends StatelessWidget {
  const ShimmerImageCarusel({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    double imageWidth = isMobile ? 1.1 : 2.2;
    final itemPadding = isMobile ? 16.0 : 24.0;
    double width = MediaQuery.sizeOf(context).width / imageWidth;
    double height = isMobile ? 370 : 550;

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
          width: width,
          height: height,
        ),
      ),
    );
  }
}
