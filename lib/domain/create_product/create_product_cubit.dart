import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/product_colors.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/utils/common.dart';

import '../../services/get_it.dart';
import '../mappers/product_mapper.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final productMapper = locate<ProductMapper>();
  final productRepository = locate<ProductRepository>();

  CreateProductCubit()
      : super(CreateProductState(
            isLoading: false,
            isEdit: false,
            errorMessage: '',
            editProduct: Product.defaultProduct(),
            initialPage: 0,
            activePage: 0,
            product: Product.defaultProduct(),
            images: [],
            dimensions: []));

  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController costPriceController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController idNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);

  void addProduct() async {
    try {
      emit(state.copyWith(isLoading: true));
      final product = productMapper.mapToNetworkProduct(
          state.product, state.product.dimensions);
      final pushProduct = await productRepository.addProduct(product);
      pushProduct.when((success) {
        nameController.clear();
        descriptionController.clear();
        costPriceController.clear();
        quantityController.clear();
        salePriceController.clear();
        colorController.clear();
        idNameController.clear();
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
      final images = <String>[...state.product.images];
      if (pickedFiles.isNotEmpty) {
        for (var element in pickedFiles) {
          final file = File(element.path);
          final imagePath = file.path;
          images.add(imagePath);
        }
        emit(state.copyWith(product: state.product.copyWith(images: images)));
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
    emit(state.copyWith(product: state.product.copyWith(name: name)));
  }

  void descriptionChanged(value) {
    final String description = value;
    emit(state.copyWith(
        product: state.product.copyWith(description: description)));
  }

  void idNameChanged(value) {
    final String idName = value;
    emit(state.copyWith(product: state.product.copyWith(idName: idName)));
  }

  void costPriceChanged(value) {
    if (value != null) {
      final double costPrice = double.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(costPrice: costPrice)));
    }
  }

//color update when change quantity

  void quantityChanged(value) {
    // TODO change implementation for color specific quantity,
    // generate dimension here and add it
    // color should be passed here to this method
    if (value != null) {
      final int quantity = int.parse(value);
      final Dimension dimension = Dimension(color: ProductColor.black.color, quantity: quantity);
      final newSetDimensions = Set<Dimension>.from(state.product.dimensions);
      newSetDimensions.add(dimension);
      emit(state.copyWith(
          product: state.product.copyWith(dimensions: newSetDimensions)));
    }
  }

  void colorChanged(value) {
  final String color = value;
  final String quantityText = quantityController.text;
  final int? quantity = quantityText.isNotEmpty ? int.tryParse(quantityText) : null;
  if (quantity != null) {
    final dimensionIndex = state.product.dimensions.toList().indexWhere((element) => element.color == color);
    if (dimensionIndex != -1) {
      final updatedDimensions = state.product.dimensions
          .map((d) => d.color == color ? d.copyWith(quantity: quantity) : d)
          .toSet();
      emit(state.copyWith(
          product: state.product.copyWith(dimensions: updatedDimensions)));
    } else {
      final dimension = Dimension(color: color, quantity: quantity);
      final updatedDimensions = Set.of(state.product.dimensions)..add(dimension);
      emit(state.copyWith(
          product: state.product.copyWith(dimensions: updatedDimensions)));
    }
  }
}

// color changet when quantity!=null

  // void colorChanged(value) {
  //   final String color = value;
  //   final int quantity = int.parse(quantityController.text);
  //   if(quantity!=null){
  //   final Dimension dimension = Dimension(color: color, quantity: quantity);
  //   final newSetDimensions = Set<Dimension>.from(state.product.dimensions);
  //   newSetDimensions.add(dimension);
  //   emit(state.copyWith(
  //       product: state.product.copyWith(dimensions: newSetDimensions)));
  //   }
  // }

  void salePriceChanged(value) {
    if (value != null) {
      final double salePrice = double.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(salePrice: salePrice)));
    }
  }

  void moveToNextPage() {
    if (state.activePage != 2) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      moxyPrint(state);
    } else {
      if (state.isEdit) {
        // editProduct();
      } else {
        addProduct();
      }
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
    emit(CreateProductState.defaultCreateProductState());
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  void clearErrorState() {
    emit(state.copyWith(errorMessage: ''));
  }

 



  //  EDIT FUNCTION
  void getProductById(id) async {
    final productById = await productRepository.getProductById(id);
    productById.when((success) {
      emit(state.copyWith(editProduct: productMapper.mapToProduct(success)));
    }, (error) {});
  }

  void fillFields(Product product) {
    nameController.text = product.name;
    descriptionController.text = product.description;
    costPriceController.text = product.costPrice.toString();
    salePriceController.text = product.salePrice.toString();
  }

  void changeEdit() {
    emit(state.copyWith(isEdit: true));
  }

  // void editProduct() async {
  //   try {
  //     emit(state.copyWith(isLoading: true));
  //     final product = Product(
  //       id: state.id,
  //       name: state.name,
  //       description: state.description,
  //       costPrice: state.costPrice,
  //       idName: state.idName,
  //       // dimensions: state.dimensions,
  //       // warehouseQuantity: state.warehouseQuantity,
  //       salePrice: state.salePrice,
  //       // color: state.color,
  //       images: state.images,
  //     );
  //     final pushProduct = await productRepository.editProduct(product);
  //     pushProduct.when((success) {
  //       nameController.clear();
  //       descriptionController.clear();
  //       costPriceController.clear();
  //       quantityController.clear();
  //       salePriceController.clear();
  //       colorController.clear();
  //       clearState();
  //     }, (error) {
  //       emit(state.copyWith(
  //           errorMessage: 'Failed', isLoading: false, activePage: 0));
  //     });
  //   } catch (e) {
  //     moxyPrint(e);
  //   }
  // }
}
