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
    _productRepository.updateSelectedProducts(selectedProducts.toList());
  }

  void orderProductsList() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _productRepository.getAllProducts();
      result.when(
        (success) {
          initSelectedProductList();
          final products = _produtctMapper.mapToProductList(success);
          final productsByColor = groupProductsByColor(products);
          emit(state.copyWith(
              allProducts: products,
              isLoading: false,
              productsByColor: productsByColor));
        },
        (error) {
          emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
        },
      );
    } catch (e) {
      moxyPrint('$e');
    }
  }

  Map<String, List<Product>> groupProductsByColor(List<Product> products) {
    final productsByColor = <String, List<Product>>{};

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
        const quantity = 1;
        final key = '$quantityKey';

        if (!productsByColor.containsKey(key)) {
          productsByColor[key] = [];
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

        productsByColor[key]?.add(newProduct);
      }
    }

    return productsByColor;
  }

  Set<OrderedItem> selectedProducts = {};

  void toggleProductSelection(Product product) {
    final productName = product.name;

    final selectedProduct = OrderedItem(
        dimensions: product.dimensions,
        productId: product.id!,
        productName: product.name);


    final matchingProducts = selectedProducts.where((selectedProduct) {
      return selectedProduct.productName == productName;
    }).toList();

    final matchingProductsWithColor = matchingProducts.where((matchingProduct) {
      return matchingProduct.dimensions
          .any((dimension) => dimension.color == product.dimensions[0].color);
    }).toList();

    if (matchingProductsWithColor.isNotEmpty) {
      selectedProducts.removeAll(matchingProductsWithColor);
    } else {
      selectedProducts.add(selectedProduct);
    }

    return emit(state.copyWith());
  }

  bool isProductSelected(Product product) {
    final productName = product.name;

    return selectedProducts.any((selectedProduct) {
      return selectedProduct.productName == productName &&
          selectedProduct.dimensions.any(
              (dimension) => dimension.color == product.dimensions[0].color);
    });
  }

  void quantityAdd(int index) {
    List<List<Product>> productsList = state.productsByColor.values.toList();
    List<String> productsListKey = state.productsByColor.keys.toList();

    if (index >= 0 && index < productsList.length) {
      List<Product> products = productsList[index];
      int maxQuantity = int.parse(productsListKey[index]);
      Dimension? dimen = products.first.dimensions.first;
      if (products.isNotEmpty && dimen.quantity < maxQuantity) {
        dimen.quantity++;
        Map<String, List<Product>> newProductsByColor =
            Map.from(state.productsByColor);
        newProductsByColor.values.toList()[index] = List.from(products);
        emit(state.copyWith(productsByColor: newProductsByColor));
      }
    }
  }

  void quantityRemove(int index) {
    List<List<Product>> productsList = state.productsByColor.values.toList();

    if (index >= 0 && index < productsList.length) {
      List<Product> products = productsList[index];
      Dimension? dimen = products.first.dimensions.first;
      if (products.isNotEmpty && dimen.quantity > 1) {
        dimen.quantity--;
        Map<String, List<Product>> newProductsByColor =
            Map.from(state.productsByColor);
        newProductsByColor.values.toList()[index] = List.from(products);
        emit(state.copyWith(productsByColor: newProductsByColor));
      }
    }
  }

  void initSelectedProductList() {
    List<OrderedItem>? selectedList =
        _productRepository.currentSelectedProducts;
    selectedProducts = selectedList?.toSet() ?? {};
  }
}
