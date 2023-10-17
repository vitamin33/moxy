import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class FavouritesState implements Copyable<FavouritesState> {
  final bool isLoading;
  final List<Product> favoriteProducts;

  FavouritesState({
    required this.isLoading,
    required this.favoriteProducts,
  });

  static defaultState() {
    return FavouritesState(
      isLoading: false,
      favoriteProducts: [],
    );
  }

  @override
  FavouritesState copyWith({
    bool? isLoading,
    List<Product>? favoriteProducts,
  }) {
    return FavouritesState(
      isLoading: isLoading ?? this.isLoading,
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
    );
  }
}
