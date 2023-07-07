import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';

class SearchTextfield extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final List<String> autofillHints;
  final int? maxLines;
  final bool validation;

  const SearchTextfield({
    Key? key,
    required this.title,
    this.controller,
    this.onChanged,
    this.maxLines,
    this.inputFormatters,
    this.autofillHints = const [],
    this.validation = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            decoration: const BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              maxLines: maxLines,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                prefixIconColor: AppTheme.gray,
                prefixStyle: TextStyle(color: AppTheme.gray),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.white)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.white)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.greyLigth)),
                hintText: title,
                contentPadding: const EdgeInsets.all(15),
              ),
            )),
      ],
    );
  }
}
