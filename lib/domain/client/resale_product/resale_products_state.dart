import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';

class ResaleProductState implements Copyable<ResaleProductState> {
  final bool isLoading;
  final List<Product> resaleProducts;
  final String errorMessage;

  ResaleProductState({
    required this.isLoading,
    required this.resaleProducts,
    required this.errorMessage,
  });

  static defaultResaleProductState() {
    return ResaleProductState(
      isLoading: false,
      resaleProducts: [Product.defaultProduct()],
      errorMessage: '',
    );
  }

  @override
  ResaleProductState copyWith({
    bool? isLoading,
    List<Product>? resaleProducts,
    String? errorMessage,
  }) {
    return ResaleProductState(
      isLoading: isLoading ?? this.isLoading,
      resaleProducts: resaleProducts ?? this.resaleProducts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}