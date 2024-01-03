import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class SearchState implements Copyable<SearchState> {
  final bool isLoading;
  final List<Product> searchProduct;

  SearchState({
    required this.isLoading,
    required this.searchProduct,
  });

  static defaultSearchState() {
    return SearchState(
      isLoading: false,
      searchProduct: [],
    );
  }

  @override
  SearchState copyWith({
    bool? isLoading,
    List<Product>? searchProduct,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      searchProduct: searchProduct ?? this.searchProduct,
    );
  }
}