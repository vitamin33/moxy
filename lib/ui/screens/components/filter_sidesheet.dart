import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/filter_catalog/filter_catalog_cubit.dart';
import 'package:moxy/domain/client/filter_catalog/filter_catalog_state.dart';
import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/sort_by.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/screens/components/custom_accordion.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class FilterSideSheet extends StatelessWidget {
  final String title;
  final String productCount;
  // final Attributes filterAttributes;
  // final List<FilterPrice> filterPrice;
  // final List<SortBy> sortBy;
  // final Function(String) onChangedSelectedColors;
  // final Function(String) onChangedSelectedPriceRange;
  // final Function(String) onChangedSelectedTimeRange;

  const FilterSideSheet({
    super.key,
    required this.title,
    required this.productCount,
    // required this.filterAttributes,
    // required this.filterPrice,
    // required this.sortBy,
    // required this.onChangedSelectedColors,
    // required this.onChangedSelectedPriceRange,
    // required this.onChangedSelectedTimeRange,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return
        // BlocProvider(
        //   create: (context) => FilterCatalogCubit(),
        //   child:
        BlocBuilder<FilterCatalogCubit, FilterCatalogState>(
      builder: (context, state) {
        final cubit = context.read<FilterCatalogCubit>();
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
                  Column(
                    children: [
                      CustomAccordion(
                          title: 'COLOR',
                          contentChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (ProductColor color
                                  in state.attributes.colors)
                                InkWell(
                                  onTap: () {
                                    cubit.onChangeFilterColor(color.name);
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          key: key,
                                          side: const BorderSide(
                                              color: AppTheme.gray, width: 0.5),
                                          hoverColor: AppTheme.white,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            if (!states.contains(
                                                MaterialState.selected)) {
                                              return AppTheme.white;
                                            }
                                            return AppTheme.gray;
                                          }),
                                          checkColor: AppTheme.white,
                                          activeColor: AppTheme.gray,
                                          value: color.isSelected,
                                          onChanged: (onChanged) {
                                            // onChanged == !onChanged!;
                                            cubit.onChangeFilterColor(
                                                color.name);
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
                              for (FilterPrice price in state.filterPrice)
                                InkWell(
                                  onTap: () {
                                    cubit.onChangeFilterPrice(price.name);
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          side: const BorderSide(
                                              color: AppTheme.gray, width: 0.5),
                                          hoverColor: AppTheme.white,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            if (!states.contains(
                                                MaterialState.selected)) {
                                              return AppTheme.white;
                                            }
                                            return AppTheme.gray;
                                          }),
                                          checkColor: AppTheme.white,
                                          activeColor: AppTheme.gray,
                                          value: price.isSelected,
                                          onChanged: (onChanged) {
                                            cubit.onChangeFilterPrice(
                                                price.name);
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
                              for (SortBy time in state.sortBy)
                                InkWell(
                                  onTap: () {
                                    cubit.onChangeFilterTime(time.name);
                                  },
                                  child: Row(
                                    children: [
                                      Checkbox(
                                          key: key,
                                          side: const BorderSide(
                                              color: AppTheme.gray, width: 0.5),
                                          hoverColor: AppTheme.white,
                                          fillColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            if (!states.contains(
                                                MaterialState.selected)) {
                                              return AppTheme.white;
                                            }
                                            return AppTheme.gray;
                                          }),
                                          checkColor: AppTheme.white,
                                          activeColor: AppTheme.gray,
                                          value: time.isSelected,
                                          onChanged: (onChanged) {
                                            cubit.onChangeFilterTime(time.name);
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
      },
    );
  }
}
