import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/constant/product_categories.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/data/models/response/media_response.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/extensions.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../../environment.dart';

class ProductsService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  ProductsService(this._dio);

  Future<CreateProduct?> createProduct(
    String name,
    String? description,
    double costPrice,
    double salePrice,
    List<NetworkDimension> dimensions,
    String idName,
    String category,
    NetworkProductAttributes attributes,
    List<String> choosenImages,
    List<int> numberOfChosenImages,
  ) async {
    final CreateProduct? result;
    List<MultipartFile> imageFiles = [];
    for (String image in choosenImages) {
      moxyPrint('Image path: $image');
      String fileName = basename(image);
      imageFiles.add(
        await MultipartFile.fromFile(
          image,
          filename: fileName,
        ),
      );
    }
    FormData formData = FormData.fromMap({
      'name': name,
      'description': description ?? '',
      'costPriceInUsd': costPrice,
      'salePrice': salePrice,
      'dimensions': jsonDecode(jsonEncode(dimensions)),
      'numberOfImagesForDimensions':
          jsonDecode(jsonEncode(numberOfChosenImages)),
      'images': imageFiles,
      'idName': idName,
      'category': category,
      'attributes': jsonDecode(jsonEncode(attributes))
    });
    try {
      Response response = await _dio.post(
        createProductUrl,
        data: formData,
      );
      result = CreateProduct.fromJson(response.data);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
    return result;
  }

  Future<List<NetworkProduct>> allProducts() async {
    try {
      final response = await _dio.get(allProductsUrl);
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<NetworkProduct> getProductById(String id) async {
    try {
      final response = await _dio.get('$baseUrl$getProductByIdUrl$id');
      final data = response.data;
      final result = NetworkProduct.fromJson(data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> editProduct(
    String? id,
    String name,
    String? description,
    String idName,
    String category,
    List<NetworkDimension> dimensions,
    double costPriceInUsd,
    double salePrice,
    NetworkProductAttributes attributes,
    List<String> choosenImages,
    List<int> numberOfChosenImages,
    editProductId,
  ) async {
    List<MultipartFile> newImage = [];
    for (String image in choosenImages) {
      String fileName = basename(image);
      newImage.add(
        await MultipartFile.fromFile(
          image,
          filename: fileName,
        ),
      );
    }
    FormData formData = FormData.fromMap({
      'name': name,
      'description': description ?? '',
      'costPriceInUsd': costPriceInUsd,
      'salePrice': salePrice,
      'idName': idName,
      'category': category,
      'newImages': newImage,
      'dimensions': jsonDecode(jsonEncode(dimensions)),
      'numberOfImagesForDimensions':
          jsonDecode(jsonEncode(numberOfChosenImages)),
      'attributes': jsonDecode(jsonEncode(attributes))
    });
    try {
      Response response = await _dio.post(
        '$baseUrl/products/edit/$editProductId',
        data: formData,
      );

      int statusCode = response.statusCode ?? 0;
      return statusCode.isSuccessful();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NetworkProduct>> getSellingProducts() async {
    try {
      final response = await _dio.get('$baseUrl$allSellingProductsUrl');
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NetworkProduct>> getRecomendedProducts() async {
    try {
      final response = await _dio.get('$baseUrl$getRecomendedProductsUrl');
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NetworkProduct>> getResaleProducts() async {
    try {
      final response = await _dio.get('$baseUrl$getResaleProductsUrl');
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NetworkProduct>> getBagsCatalog() async {
    try {
      final response = await _dio
          .get('$baseUrl$getCatalogUrl${ProductCategory.bags.urlSegment}');
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NetworkProduct>> getAccessoriesCatalog() async {
    try {
      final response = await _dio.get(
          '$baseUrl $getCatalogUrl${ProductCategory.accessories.urlSegment}');
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      Response response = await _dio.delete('$allProductsUrl/$productId');
      if (response.statusCode == HttpStatus.ok) {
        return true;
      }
    } catch (e) {
      moxyPrint('Error during deleting product: $e');

      return false;
    }
    return false;
  }

  Future<NetworkProductDetails> getProductsDetails(String productId) async {
    try {
      final response =
          await _dio.get('$baseUrl$getProductDetailsAdvUrl/$productId');
      final data = response.data;
      final result = NetworkProductDetails.fromJson(data);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<NetworkMedia>> fetchHomeMedia() async {
    try {
      final response = await _dio.get(getHomeMediaUrl);
      final data = response.data;
      final mediaList = <NetworkMedia>[];
      for (var value in (data as List)) {
        mediaList.add(NetworkMedia.fromJson(value));
      }
      return mediaList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<List<NetworkProduct>> getSearchProducts() async {
    try {
      final response = await _dio.get(allSellingProductsUrl);
      final data = response.data;
      final productList = <NetworkProduct>[];
      for (var value in (data as List)) {
        productList.add(NetworkProduct.fromJson(value));
      }
      return productList;
    } catch (e) {
      rethrow;
    }
  }
}
