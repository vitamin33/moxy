import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/sort_by.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/screens/components/custom_accordion.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class FilterSideSheet extends StatefulWidget {
  final String title;
  final String productCount;
  final List<ProductColor> filterColors;
  final List<FilterPrice> filterPrice;
  final List<SortBy> sortBy;
  final Function(List<ProductColor> colors, List<FilterPrice> prices,
      List<SortBy> sortBy) onApplyFilters;

  const FilterSideSheet({
    super.key,
    required this.title,
    required this.productCount,
    required this.filterColors,
    required this.filterPrice,
    required this.sortBy,
    required this.onApplyFilters,
  });

  @override
  State<FilterSideSheet> createState() => _FilterSideSheetState();
}

class _FilterSideSheetState extends State<FilterSideSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Filter', style: theme.bigTitleBoltText),
                    const Divider(color: AppTheme.gray),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
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
              Column(
                children: [
                  CustomAccordion(
                      title: 'COLOR',
                      contentChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (ProductColor color in widget.filterColors)
                            InkWell(
                              onTap: () {
                                _checkColorByName(color.name);
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                      key: ValueKey(color.name),
                                      side: const BorderSide(
                                          color: AppTheme.gray, width: 0.5),
                                      hoverColor: AppTheme.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (!states
                                            .contains(MaterialState.selected)) {
                                          return AppTheme.white;
                                        }
                                        return AppTheme.gray;
                                      }),
                                      checkColor: AppTheme.white,
                                      activeColor: AppTheme.gray,
                                      value: color.isSelected,
                                      onChanged: (onChanged) {
                                        _checkColorByName(color.name);
                                      }),
                                  Text(
                                    color.name,
                                    style: theme.titleText
                                        .copyWith(color: AppTheme.black),
                                  )
                                ],
                              ),
                            )
                        ],
                      )),
                  const Divider(
                    color: AppTheme.gray,
                  ),
                  CustomAccordion(
                      title: 'PRICE',
                      contentChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (FilterPrice price in widget.filterPrice)
                            InkWell(
                              onTap: () {
                                _checkFilterPriceByName(price.name);
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                      key: ValueKey(price.name),
                                      side: const BorderSide(
                                          color: AppTheme.gray, width: 0.5),
                                      hoverColor: AppTheme.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (!states
                                            .contains(MaterialState.selected)) {
                                          return AppTheme.white;
                                        }
                                        return AppTheme.gray;
                                      }),
                                      checkColor: AppTheme.white,
                                      activeColor: AppTheme.gray,
                                      value: price.isSelected,
                                      onChanged: (onChanged) {
                                        _checkFilterPriceByName(price.name);
                                      }),
                                  Text(
                                    price.name,
                                    style: theme.titleText
                                        .copyWith(color: AppTheme.black),
                                  )
                                ],
                              ),
                            )
                        ],
                      )),
                  const Divider(
                    color: AppTheme.gray,
                  ),
                  CustomAccordion(
                      title: 'SORT BY',
                      contentChild: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (SortBy time in widget.sortBy)
                            InkWell(
                              onTap: () {
                                _checkSortByByName(time.name);
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                      key: ValueKey(time.name),
                                      side: const BorderSide(
                                          color: AppTheme.gray, width: 0.5),
                                      hoverColor: AppTheme.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) {
                                        if (!states
                                            .contains(MaterialState.selected)) {
                                          return AppTheme.white;
                                        }
                                        return AppTheme.gray;
                                      }),
                                      checkColor: AppTheme.white,
                                      activeColor: AppTheme.gray,
                                      value: time.isSelected,
                                      onChanged: (onChanged) {
                                        _checkSortByByName(time.name);
                                      }),
                                  Text(
                                    time.name,
                                    style: theme.titleText
                                        .copyWith(color: AppTheme.black),
                                  )
                                ],
                              ),
                            )
                        ],
                      )),
                  const Divider(
                    color: AppTheme.gray,
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomButton(
              title: 'View Results',
              onTap: () {
                widget.onApplyFilters(
                    widget.filterColors, widget.filterPrice, widget.sortBy);
                Navigator.pop(
                  context,
                );
              },
              buttonWidth: double.infinity,
            ),
          )
        ],
      ),
    );
  }

  void _checkColorByName(String name) {
    for (var color in widget.filterColors) {
      if (color.name == name) {
        color.isSelected = !color.isSelected;
      }
    }
    setState(() {});
  }

  void _checkFilterPriceByName(String name) {
    for (var price in widget.filterPrice) {
      if (price.name == name) {
        price.isSelected = !price.isSelected;
      }
    }
    setState(() {});
  }

  void _checkSortByByName(String name) {
    for (var price in widget.sortBy) {
      if (price.name == name) {
        price.isSelected = !price.isSelected;
      }
    }
    setState(() {});
  }
}
