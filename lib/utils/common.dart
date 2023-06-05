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
