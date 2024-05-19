import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';

class CustomPasswordTextField extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final List<String> autofillHints;
  final int maxLines;
  final int mixLines;
  final bool validation;
  final bool expands;
  final ScrollPhysics? scrollPhysics;
  final FieldError? state;
  final Color? borderColor;
  final bool isClearButton;
  const CustomPasswordTextField(
      {super.key,
      required this.title,
      required this.controller,
      this.onChanged,
      this.maxLines = 1,
      this.mixLines = 1,
      this.scrollPhysics,
      this.inputFormatters,
      this.autofillHints = const [],
      this.validation = false,
      this.expands = false,
      this.state,
      this.borderColor,
      this.isClearButton = false});

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool obsureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, bottom: 3),
          child: Text(
            widget.title,
            style: renderTitleStyle(context, isValid(widget.state)),
          ),
        ),
        Container(
          height: SizeConfig().heightSize(context, 7.0),
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  obscureText: obsureText,
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  onChanged: widget.onChanged,
                  controller: widget.controller,
                  maxLines: widget.maxLines,
                  inputFormatters: widget.inputFormatters,
                  autofillHints: widget.autofillHints,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            obsureText = !obsureText;
                          });
                        },
                        child: Icon(
                            obsureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey),
                      ),
                    ),
                    border: _renderBorder(
                        isValid(widget.state), false, widget.borderColor),
                    enabledBorder: _renderBorder(
                        isValid(widget.state), false, widget.borderColor),
                    focusedBorder: _renderBorder(
                        isValid(widget.state), true, widget.borderColor),
                    hintText: widget.title,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ),
              if (widget.isClearButton)
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        widget.controller.text = '';
                        widget.onChanged!('');
                      },
                      icon: const Icon(size: 20, Icons.delete),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

OutlineInputBorder _renderBorder(bool isValid, bool focused, borderColor) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: isValid ? borderColor ?? Colors.white : Colors.red,
        width: focused ? 2 : 1),
  );
}

bool isValid(state) => state == null;

TextStyle renderTitleStyle(BuildContext context, bool isValid) {
  return TextStyle(
    color: isValid ? Colors.black : Colors.red,
    fontSize: SizeConfig().heightSize(context, 3.0),
    fontWeight: FontWeight.w400,
  );
}
