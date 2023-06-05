import 'package:flutter/material.dart';

Widget loader() {
  return const Column(children: [
    Expanded(
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 1.0,
        ),
      ),
    )
  ]);
}
