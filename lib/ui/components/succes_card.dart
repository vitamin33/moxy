import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/icon_path.dart';
import '../theme/app_theme.dart';
import 'custom_button.dart';

class SuccessCard extends StatelessWidget {
  final Function onTap;
  final String title;
  final String titleButton;
  const SuccessCard(
      {super.key,
      required this.onTap,
      required this.title,
      required this.titleButton});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints.expand(),
      color: AppTheme.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: AppTheme.pink),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AnimatedLogo(),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: theme.headlineBoltText,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    OutlineStateButton(
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
}

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
      duration: const Duration(seconds: 1),
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
