import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moxy/ui/screens/components/shimmer/shimer_product.dart';
import 'package:moxy/utils/responsive_utils.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHorizontalList extends StatelessWidget {
  const ShimmerHorizontalList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    return Row(
      children: [
        Expanded(
          child: StaggeredGrid.count(
            crossAxisCount: isMobile ? 1 : 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            children: const [
              ShimmerSmallBlockGrid(),
              ShimmerSmallBlockGrid(),
              ShimmerSmallBlockGrid(),
              ShimmerSmallBlockGrid(),
            ],
          ),
        ),
      ],
    );
  }
}

class ShimmerSmallBlockGrid extends StatelessWidget {
  const ShimmerSmallBlockGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: ShimmerProductCard(),
    );
  }
}

class ShimmerMediaBlockGrid extends StatelessWidget {
  const ShimmerMediaBlockGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);

    return StaggeredGridTile.count(
      crossAxisCellCount: isMobile ? 1 : 2,
      mainAxisCellCount: isMobile ? 1 : 2,
      child: Padding(
          padding: EdgeInsets.all(isMobile ? 0.0 : 16.0),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[300]!,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
            ),
          )),
    );
  }
}
