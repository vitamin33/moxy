import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/filter_catalog/filter_catalog_cubit.dart';
import 'package:moxy/domain/client/filter_catalog/filter_catalog_state.dart';
import 'package:moxy/ui/components/sidesheet.dart';
import 'package:moxy/ui/screens/components/filter_sidesheet.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

class FilterContainer extends StatelessWidget {
  final String title;
  final String productCount;
 

  const FilterContainer({
    super.key,
    required this.title,
    required this.productCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final isMobile = ResponsiveUtil.isMobile(context);

    return
        BlocBuilder<FilterCatalogCubit, FilterCatalogState>(
      builder: (context, state) {
        final cubit = context.read<FilterCatalogCubit>();
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
                          dropDownItems: state.attributes.colors
                              .map((e) => e.name)
                              .toList(),
                          onChanged: cubit.onChangeFilterColor),
                      const SizedBox(
                        width: 10,
                      ),
                      TestSelect(
                          title: 'Price',
                          dropDownItems:
                              state.filterPrice.map((e) => e.name).toList(),
                          onChanged: cubit.onChangeFilterPrice),
                      const SizedBox(
                        width: 10,
                      ),
                      TestSelect(
                          title: 'New',
                          dropDownItems:
                              state.sortBy.map((e) => e.name).toList(),
                          onChanged: cubit.onChangeFilterTime),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TestSelect extends StatefulWidget {
  final String title;
  final List<String> dropDownItems;
  final Function(String) onChanged;

  const TestSelect({
    super.key,
    required this.title,
    required this.dropDownItems,
    required this.onChanged,
  });

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
