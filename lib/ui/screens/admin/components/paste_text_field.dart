import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class PasteTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onPasted;
  final List<TextInputFormatter>? inputFormatters;
  final List<String> autofillHints;
  final int? maxLines;
  final bool validation;
  final FieldError? state;
  final Color? borderColor;
  const PasteTextField(
      {Key? key,
      required this.title,
      this.controller,
      this.onChanged,
      this.onPasted,
      this.maxLines,
      this.inputFormatters,
      this.autofillHints = const [],
      this.validation = false,
      this.state,
      this.borderColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0.0, bottom: 3),
          child: Text(
            title,
            style: renderTitleStyle(context, isValid(state)),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: TextField(
                  onChanged: onChanged,
                  controller: controller,
                  maxLines: maxLines,
                  inputFormatters: inputFormatters,
                  autofillHints: autofillHints,
                  decoration: InputDecoration(
                    border: _renderBorder(isValid(state), false, borderColor),
                    enabledBorder:
                        _renderBorder(isValid(state), false, borderColor),
                    focusedBorder:
                        _renderBorder(isValid(state), true, borderColor),
                    hintText: title,
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      onPasted?.call();
                    },
                    icon: const Icon(size: 20, Icons.paste),
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
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );
}
