import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/filter_catalog.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/ui/components/sidesheet.dart';
import 'package:moxy/ui/screens/components/filter_sidesheet.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

class FilterContainer extends StatelessWidget {
  final String title;
  final String productCount;
  final String selectedColors;
  final String selectedPriceRange;
  final String selectedTimeRange;
  final List<String> filterProductColors;
  final Function(String) onChangedSelectedColors;
  final Function(String) onChangedSelectedPriceRange;
  final Function(String) onChangedSelectedTimeRange;

  const FilterContainer({
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
    final isMobile = ResponsiveUtil.isMobile(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.bigTitleSemiBoltText,
                    ),
                    Text(
                      "($productCount)",
                      style: theme.titleSemiBoltText,
                    ),
                  ],
                ),
                if (isMobile)
                  InkWell(
                    onTap: () {
                      SideSheet.right(
                          body: FilterSideSheet(
                            title: 'Сумки',
                            productCount: productCount,
                            selectedColors: selectedColors,
                            selectedPriceRange: selectedPriceRange,
                            selectedTimeRange: selectedTimeRange,
                            filterProductColors: filterProductColors,
                            onChangedSelectedColors: onChangedSelectedColors,
                            onChangedSelectedPriceRange:
                                onChangedSelectedPriceRange,
                            onChangedSelectedTimeRange:
                                onChangedSelectedTimeRange,
                          ),
                          context: context);
                    },
                    child: SvgPicture.asset(
                      IconPath.filter,
                    ),
                  )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (!isMobile)
              Row(
                children: [
                  TestSelect(
                      title: 'Color',
                      dropDownItems: filterProductColors,
                      selectedValue: selectedColors,
                      onChanged: onChangedSelectedColors),
                  const SizedBox(
                    width: 10,
                  ),
                  TestSelect(
                      title: 'Price',
                      dropDownItems: filterRangePrice,
                      selectedValue: selectedPriceRange,
                      onChanged: onChangedSelectedPriceRange),
                  const SizedBox(
                    width: 10,
                  ),
                  TestSelect(
                      title: 'New',
                      dropDownItems: filterTime,
                      selectedValue: selectedTimeRange,
                      onChanged: onChangedSelectedTimeRange),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class TestSelect extends StatefulWidget {
  final String title;
  final String selectedValue;
  final List<String> dropDownItems;
  final Function(String) onChanged;

  const TestSelect(
      {super.key,
      required this.title,
      required this.dropDownItems,
      required this.onChanged,
      required this.selectedValue});

  @override
  State<TestSelect> createState() => _TestSelectState();
}

class _TestSelectState extends State<TestSelect> {
  var myServices;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 50,
        width: 150,
        decoration: const BoxDecoration(
            color: AppTheme.white,
            border:
                Border(bottom: BorderSide(width: 2, color: AppTheme.black))),
        child: Center(
          child: DropdownButton<String>(
              hint: Text(widget.title),
              elevation: 16,
              underline: const SizedBox(),
              isExpanded: true,
              style: theme.largeText,
              onChanged: (String? changedValue) {
                widget.onChanged(changedValue!);
                myServices = changedValue;
                setState(() {
                  myServices;
                });
              },
              value: myServices,
              items: widget.dropDownItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
        ),
      ),
    ]);
  }
}
