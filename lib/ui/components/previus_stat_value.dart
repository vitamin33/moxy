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
    Key? key,
    required this.title,
    required this.iconPath,
    required this.value,
    required this.percentageValue,
    this.showCurrency = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.gray),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${showCurrency ? '\$ ' : ''}$value',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
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
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: percentageValue >= 0
                                ? AppTheme.greenDark
                                : AppTheme.red)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
