import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/product_details.dart';
import 'package:moxy/domain/models/review.dart';

import '../../validation_mixin.dart';

class ProductDetailsState implements Copyable<ProductDetailsState> {
  final bool isLoading;
  final ProductDetails productDetails;
  ReviewStats reviewStats;
  List<ImagePath> allImages = [];
  FieldErrors errors;

  ProductDetailsState({
    required this.isLoading,
    required this.errors,
    required this.productDetails,
    required this.allImages,
    required this.reviewStats,
  });

  static defaultProductDetailsState() {
    return ProductDetailsState(
      isLoading: false,
      errors: FieldErrors(),
      productDetails: ProductDetails.defaultProductDetails(),
      reviewStats: ReviewStats.defaultReviewStats(),
      allImages: [],
    );
  }

  @override
  ProductDetailsState copyWith({
    FieldErrors? errors,
    bool? isLoading,
    ProductDetails? productDetails,
    ReviewStats? reviewStats,
    List<ImagePath>? allImages,
  }) {
    return ProductDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errors: errors ?? this.errors,
      productDetails: productDetails ?? this.productDetails,
      reviewStats: reviewStats ?? this.reviewStats,
      allImages: allImages ?? this.allImages,
    );
  }
}

class FieldErrors {
  FieldError? emailUser;

  FieldErrors({
    this.emailUser,
  });

  static FieldErrors noErrors() {
    return FieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (emailUser != null) {
      buffer.write('emailUser ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
