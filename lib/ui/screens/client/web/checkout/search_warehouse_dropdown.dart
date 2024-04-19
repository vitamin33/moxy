import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/warehouse.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import '../../../../../domain/admin/create_order/search_warehouse/search_warehouse_cubit.dart';
import '../../../../../domain/admin/create_order/search_warehouse/search_warehouse_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchWarehouseDropdown extends StatelessWidget {
  final Warehouse? selectedWarehouse;
  final City selectedCity;
  final ValueChanged onChanged;

  const SearchWarehouseDropdown({
    super.key,
    required this.selectedWarehouse,
    required this.onChanged,
    required this.selectedCity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SearchWarehouseCubit, SearchWarehouseState>(
          builder: (context, state) {
            final warehouseSearchCubit = context.read<SearchWarehouseCubit>();
            return DropdownSearch<Warehouse>(
              dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)))),
              items: state.warehouseList,
              asyncItems: (String searchTerm) {
                return warehouseSearchCubit.searchWarehouse(
                    searchTerm, selectedCity.deliveryCityRef);
              },
              popupProps: PopupPropsMultiSelection.menu(
                emptyBuilder: (context, searchEntry) {
                  return Center(
                    child:
                        Text(AppLocalizations.of(context)!.warehouseNotFound),
                  );
                },
                loadingBuilder: (context, searchEntry) {
                  return const LinearProgressIndicator();
                },
                menuProps: const MenuProps(backgroundColor: AppTheme.white),
                showSelectedItems: false,
                searchFieldProps: _createSearchFieldProps(
                    context, warehouseSearchCubit.controller),
                itemBuilder: _warehousePopupItemBuilder,
                showSearchBox: true,
                isFilterOnline: true,
              ),
              selectedItem: selectedWarehouse,
              itemAsString: selectedWarehouse!.description != ''
                  ? (Warehouse warehouse) => warehouse.description.toString()
                  : (Warehouse warehouse) =>
                      AppLocalizations.of(context)!.chooseWarehouse,
              onChanged: (Warehouse? warehouse) {
                onChanged(warehouse);
              },
            );
          },
        )
      ],
    );
  }

  Widget _warehousePopupItemBuilder(
      BuildContext context, Warehouse item, bool isSelected) {
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
        title: Text(item.description),
        subtitle: Text(item.ref),
      ),
    );
  }

  TextFieldProps _createSearchFieldProps(
      BuildContext context, TextEditingController controller) {
    return TextFieldProps(
      cursorColor: AppTheme.pinkDark,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.chooseWarehouse,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.greyDark,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.pinkDark,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      controller: controller,
    );
  }
}
