import 'package:flutter/material.dart';

void moxyPrint(dynamic value) {
  debugPrint(value.toString());
}

int timeNow() {
  return DateTime.now().millisecondsSinceEpoch;
}

final phoneNumberRegExp = RegExp(
  r'^(?:[+0-9])?[0-9]{10,12}$',
  caseSensitive: false,
  multiLine: true,
);
final nameSurnameRegExp = RegExp(
  r"^[A-Z][a-z]+\s[A-Z][a-z]+$",
  caseSensitive: false,
  multiLine: true,
);

Color hexToColor(String code) {
  // Remove any leading # character
  code = code.replaceAll("#", "");

  // Parse the hex color code as an integer
  int intValue = int.parse(code, radix: 16);

  // Create the Color object from the integer value
  return Color(intValue)
      .withAlpha(255); // Set alpha to 255 for fully opaque color
}
