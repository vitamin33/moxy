import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:moxy/ui/screens/components/big_block_grid.dart';
import 'package:moxy/ui/screens/components/small_block_grid.dart';

class ProductListGrid extends StatelessWidget {
  final bool bigBlockLeading;
  const ProductListGrid({super.key, required this.bigBlockLeading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 700,
      child: Row(
        children: [
          Expanded(
              child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 10,
            children: [
              if (bigBlockLeading == true) const BigBlockGrid(),
              const SmallBlockGrid(),
              const SmallBlockGrid(),
              if (bigBlockLeading == false) const BigBlockGrid(),
              const SmallBlockGrid(),
              const SmallBlockGrid()
            ],
          )),
        ],
      ),
    );
  }
}
