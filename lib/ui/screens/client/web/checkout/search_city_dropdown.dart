import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/admin/create_order/search_cities/search_cities_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:moxy/domain/admin/create_order/search_cities/search_cities_state.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import '../../../../../domain/admin/create_order/search_warehouse/search_warehouse_cubit.dart';
import '../../../../../domain/models/warehouse.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchCityDropdown extends StatelessWidget {
  final Warehouse? selectedWarehouse;
  final City selectedCity;
  final ValueChanged onChanged;

  const SearchCityDropdown({
    super.key,
    required this.selectedWarehouse,
    required this.onChanged,
    required this.selectedCity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SearchCitiesCubit, SearchCitiesState>(
          builder: (context, state) {
            final citySearchCubit = context.read<SearchCitiesCubit>();
            final warehousSearchCubit = context.read<SearchWarehouseCubit>();
            return DropdownSearch<City>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)))),
                items: state.cityList,
                asyncItems: citySearchCubit.searchCities,
                popupProps: PopupPropsMultiSelection.menu(
                  emptyBuilder: (context, searchEntry) {
                    return Center(
                        child:
                            Text(AppLocalizations.of(context)!.cityNotFound));
                  },
                  loadingBuilder: (context, searchEntry) {
                    return const LinearProgressIndicator();
                  },
                  menuProps: const MenuProps(backgroundColor: AppTheme.white),
                  showSelectedItems: false,
                  searchFieldProps: _createSearchFieldProps(
                      context, citySearchCubit.controller),
                  itemBuilder: _cityPopupItemBuilder,
                  showSearchBox: true,
                  isFilterOnline: true,
                ),
                selectedItem: selectedCity,
                itemAsString: selectedCity.presentName != ''
                    ? (City city) => city.toString()
                    : (City city) => AppLocalizations.of(context)!.chooseCity,
                onChanged: (City? city) {
                  onChanged(city);
                  warehousSearchCubit.clearWarehouse();
                });
          },
        )
      ],
    );
  }

  Widget _cityPopupItemBuilder(
      BuildContext context, City item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.presentName),
        subtitle: Text(item.ref),
      ),
    );
  }

  TextFieldProps _createSearchFieldProps(
      BuildContext context, TextEditingController controller) {
    return TextFieldProps(
      cursorColor: AppTheme.pinkDark,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.chooseCity,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.greyDark,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.darkPink,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      controller: controller,
    );
  }
}
