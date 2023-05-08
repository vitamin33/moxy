import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/utils/common.dart';

import '../../services/get_it.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(const CreateProductState.initial());

  final productRepository = locate<ProductRepository>();

  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController warehouseQuantityController =
      TextEditingController();
  final TextEditingController costPriceController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);

  void addProduct() async {
    try {
      emit(state.copyWith(isLoading: true));
      final product = CreateProduct(
        name: state.name,
        description: state.description,
        costPrice: state.costPrice,
        warehouseQuantity: state.warehouseQuantity,
        salePrice: state.salePrice,
        color: state.color,
        images: state.images,
      );
      final pushProduct = await productRepository.addProduct(product);
      pushProduct.when((success) {
        nameController.clear();
        descriptionController.clear();
        costPriceController.clear();
        warehouseQuantityController.clear();
        salePriceController.clear();
        colorController.clear();
        clearState();
      }, (error) {
        emit(state.copyWith(
            errorMessage: 'Failed', isLoading: false, activePage: 0));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  Future<void> pickImage() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage(imageQuality: 6);
      final images = <String>[...state.images];
      if (pickedFiles.isNotEmpty) {
        for (var element in pickedFiles) {
          final file = File(element.path);
          final imagePath = file.path;
          images.add(imagePath);
        }
        emit(state.copyWith(images: images));
      }
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }

  void nameChanged(value) {
    final String name = value;
    emit(state.copyWith(name: name));
  }

  void descriptionChanged(value) {
    final String description = value;
    emit(state.copyWith(description: description));
  }

  void costPriceChanged(value) {
    if (value != null) {
      final double costPrice = double.parse(value);
      emit(state.copyWith(costPrice: costPrice));
    }
  }

  void warehouseQuantityChanged(value) {
    if (value != null) {
      final int warehouseQuantity = int.parse(value);
      emit(state.copyWith(warehouseQuantity: warehouseQuantity));
    }
  }

  void salePriceChanged(value) {
    if (value != null) {
      final double salePrice = double.parse(value);
      emit(state.copyWith(salePrice: salePrice));
    }
  }

  void colorChanged(value) {
    final String color = value;
    emit(state.copyWith(color: color));
  }

  void moveToNextPage() {
    if (state.activePage != 2) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      addProduct();
    }
  }

  void moveToPreviustPage() {
    if (state.activePage != 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      return;
    }
  }

  void clearState() {
    emit(const CreateProductState.initial());
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void clearErrorState() {
    emit(state.copyWith(errorMessage: ''));
  }
}
