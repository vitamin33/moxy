import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/models/media.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import '../../theme/app_theme.dart';
import 'onhover.dart';

class MediaBlockGrid extends StatefulWidget {
  final List<Media> mediaList;
  const MediaBlockGrid({super.key, required this.mediaList});

  @override
  State<MediaBlockGrid> createState() => _MediaBlockGridState();
}

class _MediaBlockGridState extends State<MediaBlockGrid> {
  int _index = 0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        _index++;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final media = widget.mediaList[_index % widget.mediaList.length];
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 600),
                      child: Image.network(
                        media.mediaUrls.first,
                        key: ValueKey(media.id),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                    _buildCenterButton(context,theme, media.productId)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildCenterButton(BuildContext context, AppTheme theme, String productId) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Сумка',
          style: theme.bigTitleBoltText.copyWith(color: AppTheme.white),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            context.push(RouterProvider.producDetailsPath(productId));
          },
          child: OnHover(
            builder: (isHovered) {
              return Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                    color: isHovered ? AppTheme.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppTheme.white)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Дивитись',
                      style: theme.mediumText.copyWith(
                          color: isHovered ? AppTheme.black : AppTheme.white),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}
