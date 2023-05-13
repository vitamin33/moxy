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
        ));
  final List<TextEditingController> quantityControllers = [];

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

  void quantityChanged(int index, String? quantity) {
    Dimension? dimen = state.product.dimensions[index];
    if (quantity != null && quantity.isNotEmpty && dimen != null) {
      dimen.quantity = int.parse(quantity);
      final newSetDimensions =
          Map<int, Dimension>.from(state.product.dimensions)
            ..remove(index)
            ..putIfAbsent(index, () => dimen);

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
