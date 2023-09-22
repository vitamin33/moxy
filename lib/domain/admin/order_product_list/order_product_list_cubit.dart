import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/dimension_product.dart';
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
    //state.isEdit ? moxyPrint('habadga') : orderProductsList();
  }

  void productsSelected() {
    final selectedOrderedList = _produtctMapper
        .mapProductListToOrderedItemList(state.productsByDimension);
    _productRepository.updateSelectedProducts(selectedOrderedList);
  }

  void orderProductsList() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await _productRepository.getAllProducts();
      result.when(
        (success) {
          final products = _produtctMapper.mapToProductList(success);
          final selectedItems = getSelectedProductList();
          final productsByDimen = _produtctMapper.mapToGroupProductsByDimension(
            products,
            selectedItems,
          );
          emit(state.copyWith(
            allProducts: products,
            isLoading: false,
            productsByDimension: productsByDimen,
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

  List<DimensionProduct> groupProductsByDimension(List<Product> products) {
    final productsByDimension = <DimensionProduct>[];
    List<OrderedItem> selectedItems = getSelectedProductList();

    for (final product in products) {
      final productName = product.name;
      final productDescription = product.description;
      final productCostPrice = product.costPrice;
      final productSalePrice = product.salePrice;
      final productIdName = product.idName;
      List<ImagePath> productImages = product.images;
      ImagePath? path = productImages.isNotEmpty ? productImages.first : null;

      for (final dimension in product.dimensions) {
        final color = dimension.color;
        final quantity = dimension.quantity;

        final newDimension =
            Dimension(color: color, quantity: quantity, image: dimension.image);
        int selectedQuantity = 1;
        bool isSelected = selectedItems.any((element) {
          bool isDimenSelected =
              element.dimensions.any((d) => d.color == color);
          return element.productId == product.id && isDimenSelected;
        });
        if (isSelected) {
          final selectedItem = selectedItems
              .firstWhere((element) => element.productId == product.id);

          final selectedDimension = selectedItem.dimensions
              .firstWhere((element) => element.color == color);
          selectedQuantity = selectedDimension.quantity;
        }
        final newProduct = DimensionProduct(
          id: product.id,
          name: productName,
          description: productDescription,
          costPrice: productCostPrice,
          salePrice: productSalePrice,
          idName: productIdName,
          image: path,
          dimension: newDimension,
          selectedQuantity: selectedQuantity,
          isSelected: isSelected,
        );

        productsByDimension.add(newProduct);
      }
    }

    return productsByDimension;
  }

  void toggleProductSelection(int index) {
    bool isSelected = state.productsByDimension[index].isSelected;
    state.productsByDimension[index].isSelected = !isSelected;

    emit(state.copyWith(productsByDimension: state.productsByDimension));
  }

  void quantityAdd(int index) {
    List<DimensionProduct> productsList = state.productsByDimension;

    DimensionProduct product = productsList[index];
    int maxQuantity = product.dimension.quantity;
    int selectedQuantity = product.selectedQuantity;
    if (selectedQuantity < maxQuantity) {
      product.selectedQuantity++;
      emit(state.copyWith(productsByDimension: productsList));
    }
  }

  void quantityRemove(int index) {
    List<DimensionProduct> productsList = state.productsByDimension;

    DimensionProduct product = productsList[index];
    int selectedQuantity = product.selectedQuantity;
    if (selectedQuantity > 1) {
      product.selectedQuantity--;
      emit(state.copyWith(productsByDimension: productsList));
    }
  }

  List<OrderedItem> getSelectedProductList() {
    return _productRepository.currentSelectedProducts ?? [];
  }

  String productColorKey(String producName, int quantity, String color) {
    return '$producName $color $quantity';
  }
}
