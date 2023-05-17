import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/dio_client.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

class ProductRepository {
  static DioClient client = DioClient.instance;
  Future<Result<dynamic, Exception>> addProduct(NetworkProduct product) async {
    try {
      final result = (await client.createProduct(
          product.name,
          product.description,
          product.costPrice,
          product.salePrice,
          product.dimensions,
          product.images,
          product.idName));
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
      if (result != null) {
        return Result.success(result);
      } else {
        return Result.error(Exception('Result is null'));
      }
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkProduct, Exception>> getProductById(id) async {
    try {
      final result = await client.getProductById(id);
      if (result != null) {
        return Result.success(result);
      } else {
        return Result.error(Exception('Result ProductById is null'));
      }
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkProduct, Exception>> editProduct(
      NetworkProduct product,editProductId) async {
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
}
