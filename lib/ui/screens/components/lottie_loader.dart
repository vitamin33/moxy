import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: must_be_immutable
class LottieLoader extends StatelessWidget {
  double size;
  LottieLoader({super.key, this.size = 100});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset('assets/anim/default_loader.json', width: size),
    );
  }
}
