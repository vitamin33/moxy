import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/theme/app_theme.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final List<String> autofillHints;
  final int? maxLines;
  final bool validation;
  final FieldError? state;
  const CustomTextField({
    Key? key,
    required this.title,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.inputFormatters,
    this.autofillHints = const [],
    this.validation = false,
    this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        Container(
            padding: EdgeInsets.all(6),
            decoration: const BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              maxLines: maxLines,
              inputFormatters: inputFormatters,
              autofillHints: autofillHints,
              decoration: InputDecoration(
                border: _renderBorder(isValid(state), false),
                enabledBorder: _renderBorder(isValid(state), false),
                focusedBorder: _renderBorder(isValid(state), true),
                hintText: title,
                hintStyle: renderHintStyle(context, isValid(state)),
                contentPadding: const EdgeInsets.all(15),
              ),
            )),
      ],
    );
  }
}

OutlineInputBorder _renderBorder(bool isValid, bool focused) {
  return OutlineInputBorder(
    borderSide: BorderSide(
        color: isValid ? AppTheme.white : Colors.red, width: focused ? 2 : 1),
  );
}

bool isValid(state) => state == null;
TextStyle renderHintStyle(BuildContext context, bool isValid) {
  return TextStyle(
    color: isValid ? Theme.of(context).hintColor : Colors.red,
  );
}
