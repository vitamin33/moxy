import 'package:flutter/material.dart';

Widget loader() {
  return Column(children: const [
    Expanded(
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.0,
        ),
      ),
    )
  ]);
}