import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/app_theme.dart';

class CurrentStatValue extends StatelessWidget {
  final String title;
  final String iconPath;
  final String value;
  final bool showCurrency;

  const CurrentStatValue({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.value,
    this.showCurrency = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppTheme.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: AppTheme.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SvgPicture.asset(
                      iconPath,
                      color: Colors.white,
                      width: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.gray),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${showCurrency ? '₴' : ''}$value',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
