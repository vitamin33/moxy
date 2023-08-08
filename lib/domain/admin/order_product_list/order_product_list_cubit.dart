import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/utils/common.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../services/get_it.dart';
import '../../models/order.dart';
import '../../models/product.dart';
import 'order_product_list_state.dart';

class OrderProductListCubit extends Cubit<OrderProductListState> {
  final _produtctMapper = locate<ProductMapper>();
  final _productRepository = locate<ProductRepository>();

  OrderProductListCubit(OrderProductListState orderProductListState)
      : super(OrderProductListState.defaultAllProductsState()) {
    state.isEdit ? moxyPrint('habadga') : orderProductsList();
  }

  void productsSelected() {
    _productRepository.updateSelectedProducts(state.selectedProducts.toList());
  }

  void orderProductsList() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _productRepository.getAllProducts();
      result.when(
        (success) {
          final selectedProducts = getSelectedProductList();
          final products = _produtctMapper.mapToProductList(success);
          final productByColor = groupProductsByColor(products);
          emit(state.copyWith(
            allProducts: products,
            isLoading: false,
            productByColor: productByColor,
            selectedProducts: selectedProducts.toSet(),
          ));
        },
        (error) {
          emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
        },
      );
    } catch (e) {
      moxyPrint('$e');
    }
  }

  Map<String, Product> groupProductsByColor(List<Product> products) {
    final productsByColor = <String, Product>{};

    for (final product in products) {
      final productName = product.name;
      final productDescription = product.description;
      final productCostPrice = product.costPrice;
      final productSalePrice = product.salePrice;
      final productIdName = product.idName;
      final productImages = product.images;

      for (final dimension in product.dimensions) {
        final color = dimension.color;
        final quantityKey = dimension.quantity;
        final quantity = dimension.quantity;
        final key = productColorKey(product.name, quantityKey, color);

        if (!productsByColor.containsKey(key)) {
          //productsByColor[key] = [];
        }

        final newDimension = Dimension(
          color: color,
          quantity: quantity,
        );

        final newProduct = Product(
          id: product.id,
          name: productName,
          description: productDescription,
          costPrice: productCostPrice,
          salePrice: productSalePrice,
          idName: productIdName,
          images: productImages,
          dimensions: [newDimension],
        );

        productsByColor[key] = newProduct;
      }
    }

    return productsByColor;
  }

  void toggleProductSelection(Product product) {
    final productName = product.name;

    final selectedProduct = OrderedItem(
      productPrice: product.salePrice.toString(),
      dimensions: product.dimensions,
      productId: product.id!,
      productName: product.name,
    );

    final matchingProducts = state.selectedProducts.where((selectedProduct) {
      return selectedProduct.productName == productName;
    }).toList();

    final matchingProductsWithColor = matchingProducts.where((matchingProduct) {
      return matchingProduct.dimensions
          .any((dimension) => dimension.color == product.dimensions[0].color);
    }).toList();

    if (matchingProductsWithColor.isNotEmpty) {
      state.selectedProducts.removeAll(matchingProductsWithColor);
    } else {
      state.selectedProducts.add(selectedProduct);
    }

    return emit(state.copyWith(selectedProducts: state.selectedProducts));
  }

  bool isProductSelected(Product product) {
    final productName = product.name;

    return state.selectedProducts.any((selectedProduct) {
      return selectedProduct.productName == productName &&
          selectedProduct.dimensions.any(
              (dimension) => dimension.color == product.dimensions[0].color);
    });
  }

  void quantityAdd(int index) {
    List<Product> productsList = state.productByColor.values.toList();
    List<String> productsListKey = state.productByColor.keys.toList();

    if (index >= 0 && index < productsList.length) {
      Product product = productsList[index];
      int maxQuantity = int.parse(productsListKey[index][0]);
      Dimension? dimen = product.dimensions.first;
      if (dimen.quantity < maxQuantity) {
        dimen.quantity++;
        Map<String, Product> newProductsByColor = state.productByColor;
        newProductsByColor.values.toList()[index] = product;
        emit(state.copyWith(productByColor: newProductsByColor));
      }
    }
  }

  void quantityRemove(int index) {
    List<Product> productsList = state.productByColor.values.toList();

    if (index >= 0 && index < productsList.length) {
      Product product = productsList[index];
      Dimension? dimen = product.dimensions.first;
      if (dimen.quantity > 1) {
        dimen.quantity--;
        Map<String, Product> newProductsByColor = state.productByColor;
        newProductsByColor.values.toList()[index] = product;
        emit(state.copyWith(productByColor: newProductsByColor));
      }
    }
  }

  List<OrderedItem> getSelectedProductList() {
    return _productRepository.currentSelectedProducts ?? [];
  }

  String productColorKey(String producName, int quantity, String color) {
    return '$producName $color $quantity';
  }
}
