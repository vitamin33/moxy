import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/product_state.dart';
import 'package:moxy/services/image_picker_service.dart';

import '../services/get_it.dart';

class CreateProductCubit extends Cubit<ProductState> {
  CreateProductCubit() : super(const ProductState.initial());

  final productRepository = locate<ProductRepository>();
  final imagePickerService = locate<ImagePickerService>();

  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController regularPriceController = TextEditingController();
  final TextEditingController costPriceController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);

  Future<CreateProduct?> addProduct() async {
    final product = CreateProduct(
      name: state.name,
      description: state.description,
      costPrice: state.costPrice ?? 0,
      regularPrice: state.regularPrice ?? 0,
      salePrice: state.salePrice ?? 0,
      color: state.color,
      images: state.images,
    );
    final pushProduct = await productRepository.addProduct(product);
  }

  // Future<void> addProduct() async {
  //   final image = await imagePickerService.pickImages();
  //   final product = CreateProduct(
  //     name: state.name,
  //     description: state.description,
  //     costPrice: state.costPrice ?? 0,
  //     regularPrice: state.regularPrice ?? 0,
  //     salePrice: state.salePrice ?? 0,
  //     color: state.color,
  //     image: image,
  //   );
  //   final pushProduct = await productRepository.addProduct(product);
  // }

  Future<void> pickImage() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage();
      final images = <String>[];
      if (pickedFiles.isNotEmpty) {
        pickedFiles.every((element) {
          final file = File(element.path);
          final imagePath = file.path;
          images.add(imagePath);
          return true;
        });

        emit(state.copyWith(images: images));
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }

  void nameChanged(value) {
    final String name = value;
    emit(state.copyWith(name: name));
    debugPrint('$state');
  }

  void descriptionChanged(value) {
    final String description = value;
    emit(state.copyWith(description: description));
  }

  void costPriceChanged(value) {
    final int costPrice = int.parse(value);
    emit(state.copyWith(costPrice: costPrice));
  }

  void regularPriceChanged(value) {
    final double regularPrice = double.parse(value);
    emit(state.copyWith(regularPrice: regularPrice));
  }

  void salePriceChanged(value) {
    final double salePrice = double.parse(value);
    emit(state.copyWith(salePrice: salePrice));
  }

  void colorChanged(value) {
    final String color = value;
    emit(state.copyWith(color: color));
  }
}
