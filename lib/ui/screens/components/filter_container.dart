import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/filter_catalog/filter_catalog_cubit.dart';
import 'package:moxy/domain/client/filter_catalog/filter_catalog_state.dart';
import 'package:moxy/domain/filterable_cubit.dart';
import 'package:moxy/ui/components/sidesheet.dart';
import 'package:moxy/ui/screens/components/filter_sidesheet.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class FilterContainer extends StatefulWidget {
  final String title;
  final String productCount;
  final FilterableCubit parentCubit;

  const FilterContainer({
    super.key,
    required this.title,
    required this.productCount,
    required this.parentCubit,
  });

  @override
  State<FilterContainer> createState() => _FilterContainerState();
}

class _FilterContainerState extends State<FilterContainer> {
  late final FilterCatalogCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = FilterCatalogCubit(parentCubit: widget.parentCubit);
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<FilterCatalogCubit, FilterCatalogState>(
        builder: (context, state) {
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
                            widget.title,
                            style: theme.bigTitleSemiBoltText,
                          ),
                          Text(
                            "(${widget.productCount})",
                            style: theme.titleSemiBoltText,
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          SideSheet.left(
                            body: FilterSideSheet(
                              title: 'Сумки',
                              productCount: widget.productCount,
                              filterColors: state.filterColors,
                              filterPrice: state.filterPrice,
                              sortBy: state.sortBy,
                              onApplyFilters: cubit.onApplyFilters,
                            ),
                            context: context,
                          );
                        },
                        child: SvgPicture.asset(
                          IconPath.filter,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
