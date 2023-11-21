import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constant/icon_path.dart';
import '../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreviusStatValue extends StatelessWidget {
  final String title;
  final String iconPath;
  final String value;
  final double percentageValue;
  final bool showCurrency;

  const PreviusStatValue({
    super.key,
    required this.title,
    required this.iconPath,
    required this.value,
    required this.percentageValue,
    this.showCurrency = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
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
                      width: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  title,
                  style: theme.mediumText.copyWith(color: AppTheme.gray),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${showCurrency ? '₴ ' : ''}$value',
              style: theme.headlineSemiBoltText,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(percentageValue >= 0
                    ? IconPath.rightUpArrow
                    : IconPath.rightDownArrow),
                Expanded(
                    child: Text(
                        ' ${percentageValue.toStringAsFixed(2)}% ${AppLocalizations.of(context)!.overviewFromPeriod}',
                        style: theme.mediumText.copyWith(
                            color: percentageValue >= 0
                                ? AppTheme.greenDark
                                : AppTheme.red)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
