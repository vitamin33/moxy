import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KpisInfo extends StatelessWidget {
  const KpisInfo({
    super.key,
    required this.title,
    required this.avgOrderValue,
    required this.avgOrderProfit,
    required this.ltgpToCacRatio,
  });

  final String title;
  final double avgOrderValue;
  final double avgOrderProfit;
  final double ltgpToCacRatio;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    String avgOrderLabel = AppLocalizations.of(context)!.overviewAvgOrderValue;
    String avgProfitLabel =
        AppLocalizations.of(context)!.overviewAvgOrderProfit;
    String ltgpToCacLabel = AppLocalizations.of(context)!.overviewLtgpToCac;

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppTheme.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ExpandablePanel(
            header: Text(title, style: theme.smallSemiBoltText),
            collapsed: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  avgOrderLabel,
                  style: theme.mediumText.copyWith(color: AppTheme.gray),
                ),
                Text(
                  '$avgOrderValue $uah',
                  style: theme.mediumText.copyWith(color: AppTheme.greyDark),
                ),
              ],
            ),
            expanded: Column(
              children: [
                _buildAdsInfoRow(
                    theme, avgOrderLabel, avgOrderValue.toString(), uah),
                _buildAdsInfoRow(
                    theme, avgProfitLabel, avgOrderProfit.toString(), uah),
                _buildAdsInfoRow(
                    theme, ltgpToCacLabel, ltgpToCacRatio.toString(), ''),
              ],
            )),
      ),
    );
  }

  Widget _buildAdsInfoRow(
      AppTheme theme, String label, String value, String sign) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.mediumText.copyWith(color: AppTheme.gray),
        ),
        Text(
          '$value $sign',
          style: theme.mediumText.copyWith(color: AppTheme.greyDark),
        ),
      ],
    );
  }
}
