import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String? value;

  CustomDropdown({
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.onChanged,
    required this.value,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isDense: true,
          isExpanded: true,
          hint: Text(widget.hintText),
          value: widget.value,
          onChanged: widget.onChanged,
          items: widget.items,
        ),
      ),
    );
  }
}
