import 'package:flutter/material.dart';

class ContactTextField extends StatelessWidget {
  final String labelText;
  final String? prefixText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool hasError;

  const ContactTextField({
    required this.labelText,
    this.prefixText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    required this.hasError,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixText: prefixText,
        border: OutlineInputBorder(
          borderSide: hasError
              ? const BorderSide(
                  color: Colors.red,
                )
              : const BorderSide(),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: validator,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
    );
  }
}
