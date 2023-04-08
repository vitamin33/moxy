// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:either_dart/either.dart';

import '../models/product.dart';
import '../models/result.dart';

class ProductRepository {
  Future<Either<ErrorHandler, bool>> addProduct(Product product) async {
    try {
      // TODO add products
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }
}
