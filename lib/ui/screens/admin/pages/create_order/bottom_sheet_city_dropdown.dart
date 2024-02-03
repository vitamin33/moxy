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

class BottomSearchCityDropdown extends StatelessWidget {
  final Warehouse? selectedWarehouse;
  final City selectedCity;
  final ValueChanged onChanged;

  // ignore: use_key_in_widget_constructors
  const BottomSearchCityDropdown({
    Key? key,
    required this.selectedWarehouse,
    required this.onChanged,
    required this.selectedCity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocConsumer<SearchCitiesCubit, SearchCitiesState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.isLoading) {
              return const CircularProgressIndicator();
            }
            final citySearchCubit = context.read<SearchCitiesCubit>();
            final warehousSearchCubit = context.read<SearchWarehouseCubit>();
            return DropdownSearch<City>(
                items: state.cityList,
                asyncItems: citySearchCubit.searchCities,
                popupProps: PopupPropsMultiSelection.modalBottomSheet(
                  showSelectedItems: false,
                  searchFieldProps:
                      _createSearchFieldProps(citySearchCubit.controller),
                  itemBuilder: _cityPopupItemBuilder,
                  showSearchBox: true,
                  isFilterOnline: true,
                  modalBottomSheetProps: const ModalBottomSheetProps(
                      enableDrag: true, shape: BeveledRectangleBorder()),
                ),
                selectedItem: selectedCity,
                itemAsString: selectedCity.presentName != ''
                    ? (City city) => city.toString()
                    : (City city) => AppLocalizations.of(context)!.city,
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
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.presentName),
        subtitle: Text(item.ref),
      ),
    );
  }

  TextFieldProps _createSearchFieldProps(TextEditingController controller) {
    return TextFieldProps(
      cursorColor: AppTheme.pinkDark,
      decoration: InputDecoration(
        labelText: 'Enter city name',
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
