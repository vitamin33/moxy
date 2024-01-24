import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class BagsCatalogState implements Copyable<BagsCatalogState> {
  final bool isLoading;
  final List<Product> bagsList;
  final String errorMessage;
  final String selectedColors;
  final String selectedPriceRange;
  final String selectedTimeRange;
  final List<String> attributes;

  BagsCatalogState({
    required this.isLoading,
    required this.bagsList,
    required this.errorMessage,
    required this.selectedColors,
    required this.selectedPriceRange,
    required this.selectedTimeRange,
    required this.attributes,
  });

  static defaultBagsCatalogState() {
    return BagsCatalogState(
      isLoading: false,
      bagsList: [],
      errorMessage: '',
      selectedColors: '',
      selectedPriceRange: '',
      selectedTimeRange: '',
      attributes: [],
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
    List<String>? attributes,
  }) {
    return BagsCatalogState(
      isLoading: isLoading ?? this.isLoading,
      bagsList: bagsList ?? this.bagsList,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedColors: selectedColors ?? this.selectedColors,
      selectedPriceRange: selectedPriceRange ?? this.selectedPriceRange,
      selectedTimeRange: selectedTimeRange ?? this.selectedTimeRange,
      attributes: attributes ?? this.attributes,
    );
  }
}
