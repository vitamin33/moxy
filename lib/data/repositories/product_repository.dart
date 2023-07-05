import 'dart:async';
import 'package:moxy/data/http/dio_client.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rxdart/subjects.dart';

import '../../domain/mappers/order_mapper.dart';
import '../../domain/models/order.dart';
import '../../services/get_it.dart';

class ProductRepository {
  final DioClient client = locate<DioClient>();
  final orderMapper = locate<OrderMapper>();
  final _selectedProductSubject = BehaviorSubject<List<OrderedItem>>();
  Stream<List<OrderedItem>> get selectedProducts =>
      _selectedProductSubject.stream;
  List<OrderedItem>? get currentSelectedProducts =>
      _selectedProductSubject.valueOrNull;

  void addToSelectedProductStream(List<OrderedItem> items) =>
      _selectedProductSubject.sink.add(items);

  Future<Result<dynamic, Exception>> addProduct(NetworkProduct product) async {
    try {
      final result = await client.createProduct(
        product.name,
        product.description,
        product.costPrice,
        product.salePrice,
        product.dimensions,
        product.images,
        product.idName,
      );
      if (result != null) {
        return Result.success(result);
      } else {
        return Result.error(Exception('sd'));
      }
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
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
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkProduct, Exception>> editProduct(
      NetworkProduct product, editProductId) async {
    try {
      final result = (await client.editProduct(
        product.id,
        product.name,
        product.description,
        product.idName,
        product.dimensions,
        product.costPrice,
        product.salePrice,
        product.images,
        editProductId,
      ));
      if (result != null) {
        return Result.success(result);
      } else {
        return Result.error(Exception('sd'));
      }
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }

  void updateSelectedProducts(List<OrderedItem> list) {
    addToSelectedProductStream(list);
  }
}
