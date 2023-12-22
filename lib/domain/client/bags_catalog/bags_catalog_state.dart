import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class BagsCatalogState implements Copyable<BagsCatalogState> {
  final bool isLoading;
  final List<Product> bagsList;
  final String errorMessage;
  final String selectedColors;
  final String selectedPriceRange;
  final String selectedTimeRange;

  BagsCatalogState({
    required this.isLoading,
    required this.bagsList,
    required this.errorMessage,
    required this.selectedColors,
    required this.selectedPriceRange,
    required this.selectedTimeRange,
  });

  static defaultBagsCatalogState() {
    return BagsCatalogState(
      isLoading: false,
      bagsList: [Product.defaultProduct()],
      errorMessage: '',
      selectedColors: '',
      selectedPriceRange: '',
      selectedTimeRange: '',
    );
  }

  @override
  BagsCatalogState copyWith({
    bool? isLoading,
    List<Product>? bagsList,
    String? errorMessage,
    String? selectedColors,
    String? selectedPriceRange,
    String? selectedTimeRange,
  }) {
    return BagsCatalogState(
      isLoading: isLoading ?? this.isLoading,
      bagsList: bagsList ?? this.bagsList,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedColors: selectedColors ?? this.selectedColors,
      selectedPriceRange: selectedPriceRange ?? this.selectedPriceRange,
      selectedTimeRange: selectedTimeRange ?? this.selectedTimeRange,
    );
  }
}
