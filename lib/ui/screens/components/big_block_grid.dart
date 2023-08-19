import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../constant/image_path.dart';
import '../../theme/app_theme.dart';
import 'onhover.dart';

class BigBlockGrid extends StatelessWidget {
  const BigBlockGrid({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      'Сумки',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55.61,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
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
                                  style: TextStyle(
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
          const Padding(
            padding: EdgeInsets.all(3.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Сумка Чіз Чорна',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text('765грн')
                ]),
          )
        ],
      ),
    );
  }
}
