import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum ButtonState { idle, loading, disabled }

class CutomButton extends StatefulWidget {
  final String title;
  final ButtonState state;
  final double? buttonWidth;
  final bool outline;
  final Function() onTap;

  const CutomButton({
    Key? key,
    required this.title,
    this.buttonWidth = 100.0,
    this.state = ButtonState.idle,
    this.outline = false,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CutomButton> createState() => _CutomButtonState();
}

class _CutomButtonState extends State<CutomButton> {
  @override
  Widget build(BuildContext context) {
    final buttonWidth = widget.buttonWidth ?? widget.buttonWidth;
    final disabled = [ButtonState.disabled].contains(widget.state);

    return SizedBox(
        width: buttonWidth,
        child: widget.outline
            ? OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppTheme.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: const EdgeInsets.all(28),
                  side: const BorderSide(
                    width: 2,
                    color: AppTheme.black,
                  ),
                ),
                onPressed: disabled ? widget.onTap : null,
                child: Text(
                  widget.title,
                  style: const TextStyle(color: AppTheme.black, fontSize: 18),
                ),
              )
            : TextButton(
                onPressed: disabled ? null : widget.onTap,
                style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    padding: const EdgeInsets.all(0),
                    backgroundColor: AppTheme.black),
                child: Container(
                  height: 56.0,
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
                          style: const TextStyle(
                              color: AppTheme.white, fontSize: 18),
                        ),
                )));
  }
}
