import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moxy/domain/models/media.dart';
import 'package:moxy/ui/screens/components/media_block_grid.dart';
import 'package:moxy/ui/screens/components/small_block_grid.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/responsive_utils.dart';

import '../../../domain/models/product.dart';

class NewProductListGrid extends StatelessWidget {
  final bool bigBlockLeading;
  final List<Product> allSellingProduct;
  final List<Media> mediaList;

  const NewProductListGrid({
    super.key,
    required this.bigBlockLeading,
    required this.mediaList,
    required this.allSellingProduct,
  });

  @override
  Widget build(BuildContext context) {
    final length = allSellingProduct.length - 1;
    final isMobile = ResponsiveUtil.isMobile(context);
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
              child: StaggeredGrid.count(
            crossAxisCount: isMobile ? 1 : 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            children: [
              if (isMobile) MediaBlockGrid(mediaList: mediaList),
              if (bigBlockLeading && !isMobile)
                MediaBlockGrid(mediaList: mediaList),
              SmallBlockGrid(
                product: allSellingProduct[random(0, length)],
              ),
              SmallBlockGrid(
                product: allSellingProduct[random(0, length)],
              ),
              if (!bigBlockLeading && !isMobile)
                MediaBlockGrid(mediaList: mediaList),
              SmallBlockGrid(
                product: allSellingProduct[random(0, length)],
              ),
              SmallBlockGrid(
                product: allSellingProduct[random(0, length)],
              ),
            ],
          )),
        ],
      ),
    );
  }
}
