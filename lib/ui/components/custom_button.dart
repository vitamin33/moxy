import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum ButtonState { idle, loading, disabled }

class CustomButton extends StatefulWidget {
  final String title;
  final ButtonState state;
  final double? buttonWidth;
  final bool outline;
  final Function() onTap;

  const CustomButton({
    super.key,
    required this.title,
    this.buttonWidth = 100.0,
    this.state = ButtonState.idle,
    this.outline = false,
    required this.onTap,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final buttonWidth = widget.buttonWidth ?? widget.buttonWidth;
    final disabled = [ButtonState.disabled].contains(widget.state);
    final theme = AppTheme.of(context)!;

    return SizedBox(
        width: buttonWidth,
        child: widget.outline
            ? OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppTheme.white,
                  shape: const RoundedRectangleBorder(),
                  padding: const EdgeInsets.all(20),
                  side: const BorderSide(
                    width: 2,
                    color: AppTheme.pinkDark,
                  ),
                ),
                onPressed: disabled ? null : widget.onTap,
                child: Text(widget.title,
                    style:
                        theme.titleBoltText.copyWith(color: AppTheme.pinkDark)),
              )
            : TextButton(
                onPressed: disabled ? null : widget.onTap,
                style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    padding: const EdgeInsets.all(0),
                    backgroundColor: AppTheme.black),
                child: Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: widget.state == ButtonState.loading
                      ? Center(
                          child: Transform.scale(
                              scale: 0.6,
                              child: const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(AppTheme.pink),
                              )))
                      : Text(
                          widget.title,
                          style: theme.titleBoltText
                              .copyWith(color: AppTheme.white),
                        ),
                )));
  }
}
