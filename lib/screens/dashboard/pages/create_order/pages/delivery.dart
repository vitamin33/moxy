import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/theme/app_theme.dart';

import '../../../../../constant/image_path.dart';

class Delivery extends StatelessWidget {
  const Delivery({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.black),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: AppTheme.white),
            width: 180,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.ukrPoshta),
                const SizedBox(
                  height: 30,
                ),
                Text('Full Payment'),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.black),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: AppTheme.white),
            width: 180,
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.novaPoshta),
                // SvgPicture.asset(IconPath.novaPoshta),
                const SizedBox(
                  height: 30,
                ),
                const Text('Cash advance'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
