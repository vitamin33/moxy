import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MoxyTextfield extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final List<String> autofillHints;
  final int? maxLines;
  const MoxyTextfield({
    Key? key,
    required this.title,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.inputFormatters,
    this.autofillHints = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        hintText: title,
        contentPadding: const EdgeInsets.all(25),
      ),
    );
  }
}
