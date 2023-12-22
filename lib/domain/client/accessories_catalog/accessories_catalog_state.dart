import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class AccessoriesCatalogState implements Copyable<AccessoriesCatalogState> {
  final bool isLoading;
  final List<Product> accessoriesList;
  final String selectedColors;
  final String selectedPriceRange;
  final String selectedTimeRange;

  AccessoriesCatalogState({
    required this.isLoading,
    required this.accessoriesList,
    required this.selectedColors,
    required this.selectedPriceRange,
    required this.selectedTimeRange,
  });

  static defaultAccessoriesCatalogState() {
    return AccessoriesCatalogState(
      isLoading: false,
      accessoriesList: [Product.defaultProduct()],
       selectedColors: '',
      selectedPriceRange: '',
      selectedTimeRange: '',
    );
  }

  @override
  AccessoriesCatalogState copyWith({
    bool? isLoading,
    List<Product>? accessoriesList,
    String? selectedColors,
    String? selectedPriceRange,
    String? selectedTimeRange,
  }) {
    return AccessoriesCatalogState(
      isLoading: isLoading ?? this.isLoading,
      accessoriesList: accessoriesList ?? this.accessoriesList,
      selectedColors: selectedColors ?? this.selectedColors,
      selectedPriceRange: selectedPriceRange ?? this.selectedPriceRange,
      selectedTimeRange: selectedTimeRange ?? this.selectedTimeRange,
    );
  }
}