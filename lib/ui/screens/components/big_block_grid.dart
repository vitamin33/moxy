import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../constant/image_path.dart';
import '../../theme/app_theme.dart';
import 'onhover.dart';

class BigBlockGrid extends StatelessWidget {
  const BigBlockGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        ImageAssets.bigPictureHome,
                      ))),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Сумки',
                      style: theme.bigTitleBoltText
                          .copyWith(color: AppTheme.white),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {},
                      child: OnHover(
                        builder: (isHovered) {
                          return Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                                color: isHovered
                                    ? AppTheme.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: AppTheme.white)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Дивитись',
                                  style: theme.mediumText.copyWith(
                                      color: isHovered
                                          ? AppTheme.black
                                          : AppTheme.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
