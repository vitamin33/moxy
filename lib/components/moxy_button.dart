import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum ButtonState { idle, loading, disabled }

class MoxyButton extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final ButtonState state;
  final Widget? leadingIcon;
  final List<Color>? gradiant;
  final Function()? onTap;

  const MoxyButton({
    Key? key,
    required this.title,
    this.titleStyle,
    this.state = ButtonState.idle,
    this.leadingIcon,
    this.gradiant,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MoxyButton> createState() => _MoxyButtonState();
}

class _MoxyButtonState extends State<MoxyButton> {
  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.gradiant ??
        [Theme.of(context).primaryColor, Theme.of(context).focusColor];
    final disabled = [ButtonState.disabled].contains(widget.state);
    return InkWell(
      onTap: disabled ? null : widget.onTap,
      child: Container(
        height: AppTheme.buttonHeight,
        constraints: const BoxConstraints(minWidth: 300),
        decoration: BoxDecoration(
            color: disabled
                ? Theme.of(context).disabledColor
                : defaultColor.length < 2
                    ? defaultColor.first
                    : null,
            borderRadius: BorderRadius.circular(15),
            gradient: disabled
                ? null
                : defaultColor.length > 1
                    ? LinearGradient(colors: defaultColor)
                    : null),
        child: widget.state == ButtonState.loading
            ? Center(
                child: Transform.scale(
                    scale: 0.6,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                    )))
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.leadingIcon != null)
                    Padding(
                      padding:
                          const EdgeInsets.only(right: AppTheme.elementSpacing),
                      child: widget.leadingIcon,
                    ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
      ),
    );
  }
}

class MoxyCircleButton extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final ButtonState state;
  final Widget? icon;
  final List<Color>? gradiant;
  final Function()? onTap;

  const MoxyCircleButton({
    Key? key,
    required this.title,
    this.titleStyle,
    this.state = ButtonState.idle,
    this.icon,
    this.gradiant,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MoxyCircleButton> createState() => _MoxyCircleButtonState();
}

class _MoxyCircleButtonState extends State<MoxyCircleButton> {
  @override
  Widget build(BuildContext context) {
    final defaultColor = widget.gradiant ??
        [Theme.of(context).primaryColor, Theme.of(context).focusColor];
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: defaultColor.length < 2 ? defaultColor.first : null,
            gradient: defaultColor.length > 1
                ? LinearGradient(
                    colors: defaultColor,
                  )
                : null),
        child: widget.state == ButtonState.loading
            ? Center(
                child: Transform.scale(
                    scale: 0.6,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).highlightColor),
                    )))
            : widget.icon,
      ),
    );
  }
}
