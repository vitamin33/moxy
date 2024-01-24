import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/filter_catalog.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/screens/components/custom_accordion.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class FilterSideSheet extends StatelessWidget {
  final String title;
  final String productCount;
  final String selectedColors;
  final String selectedPriceRange;
  final String selectedTimeRange;
  final List<String> filterProductColors;
  final Function(String) onChangedSelectedColors;
  final Function(String) onChangedSelectedPriceRange;
  final Function(String) onChangedSelectedTimeRange;
  const FilterSideSheet({
    super.key,
    required this.title,
    required this.productCount,
    required this.selectedColors,
    required this.selectedPriceRange,
    required this.selectedTimeRange,
    required this.filterProductColors,
    required this.onChangedSelectedColors,
    required this.onChangedSelectedPriceRange,
    required this.onChangedSelectedTimeRange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Filter', style: theme.headline4BoltText),
                  InkWell(
                    onTap: () {
                      Navigator.pop(
                          context, 'Data returns from left side sheet');
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppTheme.greyLigth,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            IconPath.closeDrawer,
                          ),
                        )),
                  ),
                ],
              ),
            ),
            CustomAccordion(
                title: 'COLOR',
                contentChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String color in filterProductColors)
                      InkWell(
                          onTap: () {
                            onChangedSelectedColors(color);
                          },
                          child: Text(
                            color,
                            style: theme.titleText.copyWith(
                                color: (color != selectedColors)
                                    ? AppTheme.black
                                    : AppTheme.pinkDark),
                          ))
                  ],
                )),
            const Divider(
              color: AppTheme.black,
            ),
            CustomAccordion(
                title: 'PRICE',
                contentChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String price in filterRangePrice)
                      InkWell(
                          onTap: () {
                            onChangedSelectedPriceRange(price);
                          },
                          child: Text(
                            price,
                            style: theme.titleText.copyWith(
                                color: (price != selectedPriceRange)
                                    ? AppTheme.black
                                    : AppTheme.pinkDark),
                          ))
                  ],
                )),
            const Divider(
              color: AppTheme.black,
            ),
            CustomAccordion(
                title: 'SORT BY',
                contentChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String time in filterTime)
                      InkWell(
                          onTap: () {
                            onChangedSelectedTimeRange(time);
                          },
                          child: Text(
                            time,
                            style: theme.titleText.copyWith(
                                color: (time != selectedTimeRange)
                                    ? AppTheme.black
                                    : AppTheme.pinkDark),
                          ))
                  ],
                )),
            const Divider(
              color: AppTheme.black,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomButton(
                title: 'View Results',
                onTap: () {
                  Navigator.pop(
                    context,
                  );
                },
                buttonWidth: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}
