import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({Key? key, this.onPressed, required this.icon})
      : super(key: key);

  final VoidCallback? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: AppTheme.pinkDark,
      elevation: 4.0,
      child: IconButton(
        iconSize: 35,
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
