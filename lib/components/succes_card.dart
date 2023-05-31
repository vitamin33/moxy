import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/icon_path.dart';
import '../theme/app_theme.dart';
import 'custom_button.dart';

Widget succsess(
    {required Function onTap,
    required String title,
    required String titleButton}) {
  return Container(
    alignment: Alignment.center,
    constraints: const BoxConstraints.expand(),
    color: AppTheme.pink,
    child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                color: AppTheme.white),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedLogo(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CutomButton(
                    buttonWidth: 250,
                    title: titleButton,
                    onTap: () {
                      onTap();
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
  );
}

class AnimatedLogo extends StatefulWidget {
  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
            scale: _animation.value,
            child: SvgPicture.asset(IconPath.successImage));
      },
    );
  }
}
