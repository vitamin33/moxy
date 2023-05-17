import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/product_colors.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/create_product/create_product_effects.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/utils/common.dart';
import 'package:bloc_effects/bloc_effects.dart';

import '../../services/get_it.dart';
import '../mappers/product_mapper.dart';

class CreateProductCubit extends CubitWithEffects<CreateProductState, UiEffect>
    with ValidationMixin {
  final productMapper = locate<ProductMapper>();
  final productRepository = locate<ProductRepository>();

  CreateProductCubit()
      : super(
          CreateProductState(
            isLoading: false,
            isEdit: false,
            errorMessage: '',
            editProduct: Product.defaultProduct(),
            initialPage: 0,
            activePage: 0,
            product: Product.defaultProduct(),
            images: [],
            editProductId: '',
            errors: FieldErrors.noErrors(),
          ),
        );
  List<TextEditingController> quantityControllers = [];

  final TextEditingController salePriceController = TextEditingController();
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
        salePriceController.clear();
        colorController.clear();
        idNameController.clear();
        for (var element in quantityControllers) {
          element.clear();
        }
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
      final images = <ImagePath>[...state.product.images];
      if (pickedFiles.isNotEmpty) {
        for (var element in pickedFiles) {
          final file = File(element.path);
          final imagePath = file.path;
          images.add(ImagePath(type: Type.file, imagePath: imagePath));
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

  void quantityChanged(int index, String? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null && quantity.isNotEmpty && dimen != null) {
      dimen.quantity = int.parse(quantity);
      emit(state.copyWith(product: state.product));
    }
  }

  void colorChanged(int index, Dimension? dimen, Dimension newDimen) {
    if (dimen == null) {
      return;
    }
    final updatedDimensions = Map.of(state.product.dimensions)
      ..remove(index)
      ..putIfAbsent(index, () => newDimen);
    emit(state.copyWith(
        product: state.product.copyWith(dimensions: updatedDimensions)));
  }

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
    } else {
      if (validateFields()) {
        if (state.isEdit) {
          editProduct(state.editProductId);
        } else {
          addProduct();
        }
      }
    }
  }

  void moveToPreviustPage() {
    if (state.activePage != 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      moxyPrint(state.product);
    } else {
      return;
    }
  }

  void removeImage(index) {
    final updatedImages = List<ImagePath>.from(state.product.images);
    updatedImages.removeAt(index);
    final updatedProduct = state.product.copyWith(images: updatedImages);
    emit(state.copyWith(product: updatedProduct));
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
    emit(state.copyWith(editProductId: id));
    final productById = await productRepository.getProductById(id);
    productById.when((success) {
      emit(state.copyWith(product: productMapper.mapToProduct(success)));
    }, (error) {});
    fillFields(state.product);
  }

  void fillFields(Product product) {
    nameController.text = product.name;
    descriptionController.text = product.description;
    costPriceController.text = product.costPrice.toString();
    salePriceController.text = product.salePrice.toString();
    idNameController.text = product.idName.toString();
  }

  void changeEdit() {
    emit(state.copyWith(isEdit: true));
  }

  void addColorField() {
    quantityControllers.add(TextEditingController());
    int newIndex = state.product.dimensions.length;
    List<Dimension> freeList = getFreeDimensionList(state.product.dimensions);
    if (freeList.isNotEmpty) {
      final newDimen = freeList.first;
      final updatedDimensions =
          Map<int, Dimension>.of(state.product.dimensions);
      updatedDimensions.putIfAbsent(newIndex, () => newDimen);
      emit(state.copyWith(
          product: state.product.copyWith(dimensions: updatedDimensions)));
    }
  }

  List<Dimension> getFreeDimensionList(Map<int, Dimension> dimensions) {
    final result = <Dimension>[];
    for (var element in allColorsDimens) {
      if (!dimensions.containsValue(element)) {
        result.add(element);
      }
    }
    return result;
  }

  void editProduct(editProductId) async {
    try {
      emit(state.copyWith(isLoading: true));
      final product = productMapper.mapToNetworkProduct(
          state.product, state.product.dimensions);
      final pushProduct =
          await productRepository.editProduct(product, editProductId);
      pushProduct.when((success) {
        nameController.clear();
        descriptionController.clear();
        costPriceController.clear();
        salePriceController.clear();
        colorController.clear();
        idNameController.clear();
        for (var element in quantityControllers) {
          element.clear();
        }
        clearState();
      }, (error) {
        emit(state.copyWith(
            errorMessage: 'Failed', isLoading: false, activePage: 0));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  bool validateFields() {
    final errors = FieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.product.name)) {
      errors.productName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.product.description)) {
      errors.productDescription = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.product.idName)) {
      errors.productIdName = FieldError.empty;
      noErrors = false;
    }
    if (!isValidPrice(state.product.costPrice)) {
      errors.costPrice = FieldError.invalid;
      noErrors = false;
    }
    if (!isValidPrice(state.product.salePrice)) {
      errors.salePrice = FieldError.invalid;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(ValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(errors: errors));
    return noErrors;
  }
}
