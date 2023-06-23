import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/create_order/create_order_cubit.dart';
import 'package:moxy/domain/create_order/create_order_state.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:moxy/domain/models/warehouse.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../domain/create_order/search_warehouse/search_warehouse_cubit.dart';
import '../../../../domain/create_order/search_warehouse/search_warehouse_state.dart';

class SearchWarehouseDropdown extends StatelessWidget {
  const SearchWarehouseDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return
        Column(
      children: [
        BlocBuilder<CreateOrderCubit, CreateOrderState>(
            builder: (context, orderState) {
          return BlocBuilder<SearchWarehouseCubit, SearchWarehouseState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              }
              final warehouseSearchCubit = context.read<SearchWarehouseCubit>();
              final selectedWarehouse = orderState.selectedWarehouse;
              final selectedCity = orderState.selectedCity;
              return DropdownSearch<Warehouse>(
                items: state.warehouseList,
                asyncItems: (String searchTerm) => warehouseSearchCubit
                    .searchWarehouse(searchTerm, selectedCity.deliveryCityRef),
                popupProps: PopupPropsMultiSelection.modalBottomSheet(
                  showSelectedItems: false,
                  searchFieldProps:
                      _createSearchFieldProps(warehouseSearchCubit.controller),
                  itemBuilder: _warehousePopupItemBuilder,
                  showSearchBox: true,
                  isFilterOnline: true,
                  modalBottomSheetProps: const ModalBottomSheetProps(
                      enableDrag: true, shape: BeveledRectangleBorder()),
                ),
                selectedItem: selectedWarehouse,
                itemAsString: selectedWarehouse.description != ''
                    ? (Warehouse warehouse) => warehouse.description.toString()
                    : (Warehouse warehouse) => 'Warehouse',
                onChanged: (Warehouse? warehouse) {
                  final createOrderCubit = context.read<CreateOrderCubit>();
                  createOrderCubit.selectWarehouse(warehouse);
                },
              );
            },
          );
        }),
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

  TextFieldProps _createSearchFieldProps(TextEditingController controller) {
    return TextFieldProps(
      cursorColor: AppTheme.pinkDark,
      decoration: InputDecoration(
        labelText: 'Enter warehouse',
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
