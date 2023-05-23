import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum ButtonState { idle, loading, disabled }

class CutomButton extends StatefulWidget {
  final String title;
  final ButtonState state;
  final double? buttonWidth;
  final Function()? onTap;

  const CutomButton({
    Key? key,
    required this.title,
    this.buttonWidth = 100.0,
    this.state = ButtonState.idle,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CutomButton> createState() => _CutomButtonState();
}

class _CutomButtonState extends State<CutomButton> {
  @override
  Widget build(BuildContext context) {
    final buttonWidth = widget.buttonWidth ?? widget.buttonWidth;
    return SizedBox(
      width: buttonWidth,
      child: TextButton(
        onPressed: () {
          widget.onTap!();
        },
        style: TextButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            padding: const EdgeInsets.all(28),
            backgroundColor: AppTheme.black),
        child: Text(
          widget.title,
          style: const TextStyle(color: AppTheme.white, fontSize: 18),
        ),
      ),
    );
  }
}
