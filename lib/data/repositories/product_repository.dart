// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/dio_client.dart';
import 'package:moxy/data/models/request/create_product_request.dart';

import '../models/result.dart';

class ProductRepository {
  static DioClient client = DioClient.instance;

  Future<Either<ErrorHandler, bool>> addProduct(CreateProduct product) async {
    try {
        final result = (await client.createProduct(product.name,product.description,product.costPrice,product.regularPrice,product.salePrice,product.color,product.image));
        print('Product: $result');
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }
}

// class ProductRepository{
//   static DioClient client = DioClient.instance;
// Future<Either<ErrorHandler, bool>> addProduct(CreateProduct product) async {
//     try {
//       FormData formData = FormData.fromMap({
//         'name': product.name,
//         'description': product.description,
//         'costPrice': product.costPrice,
//         'salePrice': product.salePrice,
//         'regularPrice': product.regularPrice,
//         'color': product.color,
//         'image': await MultipartFile.fromFile(product.imageFile!.path, filename: "image.jpg")
//       });
      
//       final result = (await client.createProduct(formData));
//       print('Product: $result');
//       return const Right(true);
//     } catch (e) {
//       return Left(ErrorHandler(message: e.toString()));
//     }
//   }
// }