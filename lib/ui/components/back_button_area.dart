import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/utils/responsive_utils.dart';

class BackButtonArea extends StatelessWidget {
  final Widget wrappedWidget;
  const BackButtonArea({super.key, required this.wrappedWidget});

  @override
  Widget build(BuildContext context) {
    bool canPop = RouterProvider.router.canPop();
    final isMobile = ResponsiveUtil.isMobile(context);

    return Stack(
      children: [
        Positioned.fill(
          child: wrappedWidget,
        ),
        isMobile
            ? Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: canPop
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: BackButton(onPressed: () {
                            try {
                              context.pop();
                            } catch (e) {
                              //ignore when nothing to pop
                            }
                          }),
                        )
                      : const SizedBox.shrink(),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
