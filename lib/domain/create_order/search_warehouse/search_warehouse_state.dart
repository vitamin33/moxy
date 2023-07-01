import '../../copyable.dart';
import '../../models/warehouse.dart';

class SearchWarehouseState implements Copyable<SearchWarehouseState> {
  bool isLoading;
  List<Warehouse> warehouseList;
  String? searchTerm;

  SearchWarehouseState({
    required this.isLoading,
    required this.warehouseList,
    required this.searchTerm,
  });

  static SearchWarehouseState defaultSearchWarehouseState() {
    return SearchWarehouseState(
      isLoading: false,
      warehouseList: [],
      searchTerm: null,
    );
  }

  @override
  SearchWarehouseState copyWith({
    bool? isLoading,
    List<Warehouse>? warehouseList,
    String? searchTerm,
  }) {
    return SearchWarehouseState(
      isLoading: isLoading ?? this.isLoading,
      warehouseList: warehouseList ?? this.warehouseList,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
