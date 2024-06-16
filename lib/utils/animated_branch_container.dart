import 'package:flutter/material.dart';
import 'package:moxy/utils/extensions.dart';

class AnimatedBranchContainer extends StatelessWidget {
  /// Creates a AnimatedBranchContainer
  const AnimatedBranchContainer(
      {super.key, required this.currentIndex, required this.children});

  /// The index (in [children]) of the branch Navigator to display.
  final int currentIndex;

  /// The children (branch Navigators) to display in this container.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: children.mapIndexed(
      children,
      (int index, Widget navigator) {
        // return _branchNavigatorWrapper(index, navigator);
        return AnimatedScale(
            scale: index == currentIndex ? 1.0 : 0,
            duration: const Duration(seconds: 2),
            child: AnimatedOpacity(
                opacity: index == currentIndex ? 1.0 : 0,
                duration: const Duration(seconds: 2),
                child: _branchNavigatorWrapper(index, navigator)));
      },
    ).toList());
  }

  Widget _branchNavigatorWrapper(int index, Widget navigator) => IgnorePointer(
        ignoring: index != currentIndex,
        child: TickerMode(
          enabled: index == currentIndex,
          child: navigator,
        ),
      );
}
