import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class CheckoutState implements Copyable<CheckoutState> {
  final bool isLoading;
  final String? basketProductsError;
  final List<Product> basketProducts;

  CheckoutState({
    required this.isLoading,
    required this.basketProductsError,
    required this.basketProducts,
  });

  static defaultState() {
    return CheckoutState(
      isLoading: false,
      basketProducts: [],
      basketProductsError: null,
    );
  }

  @override
  CheckoutState copyWith({
    bool? isLoading,
    String? basketProductsError,
    List<Product>? basketProducts,
  }) {
    return CheckoutState(
      isLoading: isLoading ?? this.isLoading,
      basketProductsError: basketProductsError ?? this.basketProductsError,
      basketProducts: basketProducts ?? this.basketProducts,
    );
  }
}
