import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class MoxyLoader extends StatefulWidget {
  const MoxyLoader({
    Key? key,
    this.iconSize = 20.0,
  }) : super(key: key);

  final double iconSize;

  @override
  // ignore: library_private_types_in_public_api
  _MoxyLoaderState createState() => _MoxyLoaderState();
}

class _MoxyLoaderState extends State<MoxyLoader>
    with SingleTickerProviderStateMixin {
  double? _iconSize;

  final List<Color> colors = [
    const Color.fromARGB(255, 233, 71, 217),
    AppTheme.darkPink,
    AppTheme.pinkDark,
    AppTheme.pinkAvarage,
  ];
  int currentColorIndex = 0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _iconSize = widget.iconSize;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..addListener(() {
        if (_controller.isCompleted) {
          setState(() {
            currentColorIndex = (currentColorIndex + 1) % colors.length;
          });
          _controller.reset();
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _iconSize,
      height: _iconSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colors[currentColorIndex],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Center(
          child: SvgPicture.asset(
            IconPath.moxyLogoWeb,
            width: _iconSize,
            color: AppTheme.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
