import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/data/repositories/product_repository.dart';
import 'package:moxy/domain/create_product/create_product_state.dart';
import 'package:moxy/utils/common.dart';

import '../../services/get_it.dart';

class CreateProductCubit extends Cubit<CreateProductState> {
  CreateProductCubit() : super(const CreateProductState.initial());

  final productRepository = locate<ProductRepository>();

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
      final product = CreateProduct(
        name: state.name,
        description: state.description,
        costPrice: state.costPrice,
        salePrice: state.salePrice,
        dimensions: state.dimensions,
        idName: state.idName,
        images: state.images,
      );
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
    emit(state.copyWith(name: name));
  }

  void descriptionChanged(value) {
    final String description = value;
    emit(state.copyWith(description: description));
  }

  void idNameChanged(value) {
    final String idName = value;
    emit(state.copyWith(idName: idName));
  }

  void costPriceChanged(value) {
    if (value != null) {
      final double costPrice = double.parse(value);
      emit(state.copyWith(costPrice: costPrice));
    }
  }

  void quantityChanged(value) {
    if (value != null) {
      final int quantity = int.parse(value);
      emit(state.copyWith(quantity: quantity));
    }
  }

  void salePriceChanged(value) {
    if (value != null) {
      final double salePrice = double.parse(value);
      emit(state.copyWith(salePrice: salePrice));
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
    final String color = value;
    emit(state.copyWith(color: color));
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
    emit(const CreateProductState.initial());
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
      emit(state.copyWith(productById: success));
      emit(state.copyWith(
        name: success.name,
        description: success.description,
        costPrice: success.costPrice,
        // warehouseQuantity: success.warehouseQuantity,
        salePrice: success.salePrice,
        // color: success.color,
        images: success.images,
      ));
    }, (error) {});
  }

  void fillFields(Product product) {
    nameController.text = product.name;
    descriptionController.text = product.description;
    costPriceController.text = product.costPrice.toString();
    // colorController.text = product.color;
    salePriceController.text = product.salePrice.toString();
    // warehouseQuantityController.text = product.warehouseQuantity.toString();
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
