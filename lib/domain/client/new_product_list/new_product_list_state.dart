import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/media.dart';
import 'package:moxy/domain/models/product.dart';

class NewProductListState implements Copyable<NewProductListState> {
  final bool isLoading;
  final List<Product> allSellingProduct;
  final List<Media> mediaList;
  final String errorMessage;

  NewProductListState({
    required this.isLoading,
    required this.allSellingProduct,
    required this.mediaList,
    required this.errorMessage,
  });

  static defaultNewProductListState() {
    return NewProductListState(
      isLoading: false,
      allSellingProduct: [Product.defaultProduct()],
      mediaList: [Media.defaultMedia()],
      errorMessage: '',
    );
  }

  @override
  NewProductListState copyWith({
    bool? isLoading,
    List<Product>? allSellingProduct,
    List<Media>? mediaList,
    String? errorMessage,
  }) {
    return NewProductListState(
      isLoading: isLoading ?? this.isLoading,
      allSellingProduct: allSellingProduct ?? this.allSellingProduct,
      mediaList: mediaList ?? this.mediaList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
