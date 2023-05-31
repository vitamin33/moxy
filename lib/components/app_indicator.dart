import 'package:flutter/material.dart';
import 'package:moxy/components/custom_radio.dart';
import 'package:moxy/components/dashed_path_painter.dart';

import '../theme/app_theme.dart';

class AppIndicator extends StatelessWidget {
  final List<String> inadicatorName;
  final List<Widget> pages;
  final int activePage;
  final PageController controller;

  const AppIndicator(
      {super.key,
      required this.inadicatorName,
      required this.pages,
      required this.activePage,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final lineWidth = constraints.maxWidth;
        return Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 14.0, right: 10, left: 10),
                  child: CustomPaint(
                    painter: DashedPathPainter(
                      originalPath: Path()..lineTo(lineWidth - 20, 0),
                      pathColor: Colors.grey,
                      strokeWidth: 2.0,
                      dashGapLength: 5.0,
                      dashLength: 5.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Widget>.generate(
                pages.length,
                (index) =>
                    Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRadio(
                      value: activePage == index,
                      onChanged: (value) {
                        if (controller.hasClients) {
                          controller.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        }
                      },
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      inadicatorName[index],
                      style: TextStyle(
                        color: activePage == index
                            ? AppTheme.black
                            : AppTheme.darkPink,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
