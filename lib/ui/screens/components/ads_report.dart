import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/models/ads_report.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdsReportInfo extends StatelessWidget {
  const AdsReportInfo({
    super.key,
    required this.title,
    required this.report,
  });

  final String title;
  final AdsReport report;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    String spend = AppLocalizations.of(context)!.overviewAdsSpend;
    String reached = AppLocalizations.of(context)!.overviewAdsPeopleReached;
    String cpm = AppLocalizations.of(context)!.overviewAdsCpm;
    String ctr = AppLocalizations.of(context)!.overviewAdsCtr;
    String cpc = AppLocalizations.of(context)!.overviewAdsCpc;

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
                  spend,
                  style: theme.mediumText.copyWith(color: AppTheme.gray),
                ),
                Text(
                  '${report.spendInUah} $uah',
                  style: theme.mediumText.copyWith(color: AppTheme.greyDark),
                ),
              ],
            ),
            expanded: Column(
              children: [
                _buildAdsInfoRow(theme, spend, report.spendInUah, uah),
                _buildAdsInfoRow(theme, reached, report.reach, ''),
                _buildAdsInfoRow(theme, cpm, report.cpm, usd),
                _buildAdsInfoRow(theme, ctr, report.ctr, percent),
                _buildAdsInfoRow(theme, cpc, report.cpc, usd),
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
