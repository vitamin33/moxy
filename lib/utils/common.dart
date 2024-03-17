import 'dart:math';

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
  code = code.replaceAll("#", "");
  if (code.length == 6) {
    code = 'FF$code';
  }
  int intValue = int.parse(code, radix: 16);

  return Color(intValue);
}

final _random = Random();

int random(int min, int max) => min + _random.nextInt(max - min);

class SizeConfig {
  double heightSize(BuildContext context, double value) {
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(BuildContext context, double value) {
    value /= 100;
    return MediaQuery.of(context).size.width * value;
  }
}
