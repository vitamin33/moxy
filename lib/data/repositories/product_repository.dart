import 'dart:async';
import 'package:moxy/data/http/products_service.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rxdart/subjects.dart';

import '../../domain/mappers/order_mapper.dart';
import '../../domain/models/order.dart';
import '../../services/get_it.dart';

class ProductRepository {
  final ProductsService client = locate<ProductsService>();
  final orderMapper = locate<OrderMapper>();
  final productMapper = locate<ProductMapper>();
  final _selectedProductSubject = BehaviorSubject<List<OrderedItem>>();
  Stream<List<OrderedItem>> get selectedProducts =>
      _selectedProductSubject.stream;
  List<OrderedItem>? get currentSelectedProducts =>
      _selectedProductSubject.valueOrNull;

  void addToSelectedProductStream(List<OrderedItem> items) =>
      _selectedProductSubject.sink.add(items);

  Future<Result<dynamic, Exception>> addProduct(NetworkProduct product,
      List<ImagePath> chosenImages, List<int> numberOfChosenImages) async {
    try {
      final result = await client.createProduct(
        product.name,
        product.description,
        product.costPriceInUsd,
        product.salePrice,
        product.dimensions ?? [],
        product.idName,
        product.category,
        product.attributes,
        chosenImages
            .where((e) => e.type == Type.file)
            .map((e) => e.imagePath)
            .toList(),
        numberOfChosenImages,
      );
      if (result != null) {
        return Result.success(result);
      } else {
        return Result.error(Exception('sd'));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Result<List<NetworkProduct>, Exception>> getAllProducts() async {
    try {
      final result = await client.allProducts();
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkProduct, Exception>> getProductById(id) async {
    try {
      final result = await client.getProductById(id);
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<bool, Exception>> editProduct(
      NetworkProduct product,
      List<Dimension> productDimensions,
      List<ImagePath> chosenImages,
      List<int> numberOfChosenImages,
      String editProductId) async {
    try {
      bool result = (await client.editProduct(
        product.id,
        product.name,
        product.description,
        product.idName,
        product.category,
        productDimensions
            .map((e) => productMapper.mapToNetworkDimension(e))
            .toList(),
        product.costPriceInUsd,
        product.salePrice,
        product.attributes,
        chosenImages.map((e) => e.imagePath).toList(),
        numberOfChosenImages,
        editProductId,
      ));
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  void updateSelectedProducts(List<OrderedItem> list) {
    addToSelectedProductStream(list);
  }

  Future<Result<List<NetworkProduct>, Exception>>
      getAllSellingProducts() async {
    try {
      final result = await client.getSellingProducts();
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<List<NetworkProduct>, Exception>>
      getRecomendedProducts() async {
    try {
      final result = await client.getRecomendedProducts();
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }
  
  Future<Result<List<NetworkProduct>, Exception>>
      getResaleProducts() async {
    try {
      final result = await client.getRecomendedProducts();
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }
  Future<Result<List<NetworkProduct>, Exception>> getBagsCatalog() async {
    try {
      final result = await client.getBegsCatalog();
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<bool, Exception>> deleteProduct(String productId) async {
    try {
      final result = await client.deleteProduct(productId);
      if (result) {
        return Result.success(result);
      } else {
        return Result.error(Exception('Unable to delete product'));
      }
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkProductDetails, Exception>> getProductsDetails(
      String productId) async {
    try {
      final result = await client.getProductsDetails(productId);
      return Result.success(result);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }
}
