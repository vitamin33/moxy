import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:moxy/constant/product_colors.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/create_product/create_product_effects.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/navigation_service.dart';
import 'package:moxy/utils/common.dart';
import 'package:bloc_effects/bloc_effects.dart';

import '../../navigation/home_router_cubit.dart';
import '../../services/get_it.dart';
import '../mappers/product_mapper.dart';

class CreateProductCubit extends CubitWithEffects<CreateProductState, UiEffect>
    with ValidationMixin {
  final productMapper = locate<ProductMapper>();
  final productRepository = locate<ProductRepository>();
  final navigationService = locate<NavigationService>();
  final bool isEditMode;
  final String? productId;

  CreateProductCubit({required this.productId, required this.isEditMode})
      : super(
          CreateProductState(
            isLoading: false,
            isEdit: isEditMode,
            isSuccess: false,
            errorMessage: '',
            editProduct: Product.defaultProduct(),
            initialPage: 0,
            activePage: 0,
            product: Product.defaultProduct(),
            images: [],
            editProductId: productId,
            errors: FieldErrors.noErrors(),
            allDimensions: allColorsDimens,
          ),
        ) {
    if (isEditMode && productId != null) {
      getProductById(productId);
    }
  }
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
        emit(state.copyWith(isLoading: false));
        nameController.clear();
        descriptionController.clear();
        costPriceController.clear();
        salePriceController.clear();
        colorController.clear();
        idNameController.clear();
        for (var element in quantityControllers) {
          element.clear();
        }
        emit(state.copyWith(isLoading: false));
        emit(state.copyWith(isSuccess: true));
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

  void createNew() {
    emit(state.copyWith(isSuccess: false));
    clearState();
  }

  void backToProduct(context) {
    clearState();
    // navigationService.navigatePushReplaceName(productsPath); //doesnt work

    context.read<HomeRouterCubit>().navigateTo(
          const ProductsPageState(),
        );
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

  void quantityLongAdd(int index, int? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null) {
      dimen.quantity += 10;
    }
    emit(state.copyWith(product: state.product));
  }

  void quantityAdd(int index, int? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null) {
      dimen.quantity++;
    }
    emit(state.copyWith(product: state.product));
  }

  void quantityRemove(int index, int? quantity) {
    Dimension? dimen = state.product.dimensions[index];

    if (quantity != null && dimen.quantity > 0) {
      dimen.quantity--;
    }
    emit(state.copyWith(product: state.product));
  }

  void quantityLongRemove(int index, int? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null && dimen.quantity > 0) {
      dimen.quantity -= 10;
    }
    emit(state.copyWith(product: state.product));
  }

  void quantityChanged(int index, String? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null && quantity.isNotEmpty) {
      dimen.quantity = int.parse(quantity);
      emit(state.copyWith(product: state.product));
    }
  }

  void salePriceChanged(value) {
    if (value != null) {
      final double salePrice = double.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(salePrice: salePrice)));
    }
  }

  void moveToNextPage() {
    if (state.activePage != 1) {
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
  }

  void clearErrorState() {
    emit(state.copyWith(errorMessage: ''));
  }

  //  EDIT FUNCTION
  void getProductById(id) async {
    emit(state.copyWith(editProductId: id));
    final productById = await productRepository.getProductById(id);
    productById.when((success) {
      final product = productMapper.mapToProduct(success);
      final updatedAllDimens = checkSelectedColors(product.dimensions);
      emit(state.copyWith(product: product, allDimensions: updatedAllDimens));
    }, (error) {
      moxyPrint(error);
    });
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

  void toggleColorField(int index) {
    state.allDimensions[index].isSelected =
        !state.allDimensions[index].isSelected;
    final updatedDimens = state.allDimensions;

    final selectedDimensions = state.allDimensions
        .where(
          (element) => element.isSelected,
        )
        .toList();
    emit(state.copyWith(
      allDimensions: updatedDimens,
      product: state.product.copyWith(dimensions: selectedDimensions),
    ));
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
        emit(state.copyWith(isSuccess: true));
        emit(state.copyWith(isLoading: false));
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

  List<Dimension> checkSelectedColors(List<Dimension> dimensions) {
    for (var element in state.allDimensions) {
      element.isSelected = dimensions.contains(element);
      element.quantity = dimensions
          .firstWhere(
            (e) => e.color == element.color,
            orElse: () => element,
          )
          .quantity;
    }
    return state.allDimensions;
  }
}
