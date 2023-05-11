import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/utils/common.dart';

import '../../services/get_it.dart';
import '../mappers/product_mapper.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  final produtctMapper = locate<ProductMapper>();
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
      final product = produtctMapper.mapToNetworkProduct(
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

  void quantityChanged(value) {
    // TODO change implementation for color specific quantity,
    //generate dimension here and add it
    // color should be passed here to this method
    if (value != null) {
      final int quantity = int.parse(value);
      final Dimension dimension = Dimension(color: 'Black', quantity: quantity);
      final newSetDimensions = Set<Dimension>.from(state.product.dimensions);
      newSetDimensions.add(dimension);
      emit(state.copyWith(
          product: state.product.copyWith(dimensions: newSetDimensions)));
    }
  }

  void salePriceChanged(value) {
    if (value != null) {
      final double salePrice = double.parse(value);
      emit(state.copyWith(
          product: state.product.copyWith(salePrice: salePrice)));
    }
  }

  // void updateColor(int index, String color) {
  //   final newState = state.copyWith.dimensions[index].copyWith(color: color);
  //   emit(state.copyWith.dimensions[index] = newState);
  // }

//   void updateColor(int index, String color) {
//   final newDimensions = List<Dimension>.from(state.dimensions);
//   final newState = state.copyWith(dimensions: newDimensions.map((dimension) {
//     if (dimension.index == index) {
//       return dimension.copyWith(color: color);
//     }
//     return dimension;
//   }).toList());
//   emit(newState);
// }
// void updateColor(int index, String value) {
//   final newState = state.dimensions[index].copyWith(color: value);
//   final newDimensions = List.of(state.dimensions)..[index] = newState;
//   emit(state.copyWith(dimensions: newDimensions));
// }

// void updateColor(int index, String color) {
//   final newDimensions = List<Dimension>.from(state.dimensions);
//   final newState = state.copyWith(dimensions: newDimensions.map((dimension) {
//     if (dimension.index == index) {
//       return dimension.copyWith(color: color);
//     }
//     return dimension;
//   }).toList());
//   emit(newState);
// }

// void updateColor(int index, String color) {
//   final newDimensions = List<Dimensions>.from(state.dimensions );
//   final newState = state.copyWith(dimensions: newDimensions.map((Dimension dimension) {
//     if (dimension.index == index) {
//       return dimension.copyWith(color: color);
//     }
//     return dimension;
//   }).toList());
//   emit(newState);
// }

  void colorChanged(value) {
    // quantity should be passed here to this method
    final String color = value;
    final Dimension dimension = Dimension(color: color, quantity: 1);
    final newSetDimensions = Set<Dimension>.from(state.product.dimensions);
    newSetDimensions.add(dimension);
    emit(state.copyWith(
        product: state.product.copyWith(dimensions: newSetDimensions)));
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

  //  void addDimension(String color, int quantity) {
  //   final currentState = state;

  //   final newDimensions = List<Dimensions>.from(currentState.dimensions)
  //     ..add(Dimensions(color: color, quantity: quantity));

  //   emit(currentState.copyWith(dimensions: newDimensions));
  // }

// void updateDimensions(int index, String color, int quantity) {
  // final List<Dimension> updatedDimensions = state.dimensions.map((dimension) {
  //   if (state.dimensions.indexOf(dimension) == index) {
  //     return state.dimensions.add( [color, quantity]);
  //   }
  //   return dimension;
  // }).toList();

//   final List<Dimension> updatedDimension = state.dimensions.map((dimension){
//       if(state.dimensions.indexOf( dimension) ==index){
//         return
//       }
//   }).toList();

//   emit(state.copyWith(dimensions: updatedDimensions));
// }

// void updateDemension(){
//   if(state.color!=''){
//   final newDemension = state.dimensions.add(color:state.color);
//     emit(state.copyWith(dimensions:newDemension ))
//   }
// }

  //  EDIT FUNCTION
  void getProductById(id) async {
    final productById = await productRepository.getProductById(id);
    productById.when((success) {
      emit(state.copyWith(editProduct: produtctMapper.mapToProduct(success)));
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
