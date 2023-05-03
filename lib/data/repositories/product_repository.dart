import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/dio_client.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/domain/product_cubit.dart';
import 'package:moxy/utils/common.dart';

class ProductRepository {
  static DioClient client = DioClient.instance;
  Future<dynamic> addProduct(CreateProduct product) async {
    try {
      final result = (await client.createProduct(
          product.name,
          product.description,
          product.warehouseQuantity,
          product.costPrice,
          product.salePrice,
          product.color,
          product.images));
      return true;
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return false;
    }
  }
}
