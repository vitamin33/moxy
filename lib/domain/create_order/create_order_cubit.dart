import 'package:flutter/material.dart';
import 'package:moxy/utils/common.dart';

import '../../data/repositories/product_repository.dart';
import '../../services/get_it.dart';
import '../../services/navigation_service.dart';
import '../mappers/product_mapper.dart';
import '../models/status.dart';
import '../ui_effect.dart';
import '../validation_mixin.dart';
import 'create_order_state.dart';
import 'package:bloc_effects/bloc_effects.dart';

class CreateOrderCubit extends CubitWithEffects<CreateOrderState, UiEffect>
    with ValidationMixin {
  final productMapper = locate<ProductMapper>();
  final productRepository = locate<ProductRepository>();
  final navigationService = locate<NavigationService>();

  CreateOrderCubit(super.initialState);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);

  // void addOrder() async {
  //   try {
  //     emit(state.copyWith(isLoading: true));
  //     // final product = productMapper.mapToNetworkProduct(
  //     //     state.product, state.product.dimensions);
  //     // final pushProduct = await productRepository.addProduct(product);
  //     final pushOrder;
  //     pushOrder.when((success) {
  //       emit(state.copyWith(isLoading: false));
  //       nameController.clear();
  //       descriptionController.clear();
  //       costPriceController.clear();
  //       salePriceController.clear();
  //       colorController.clear();
  //       idNameController.clear();
  //       emit(state.copyWith(isLoading: false));
  //       emit(state.copyWith(isSuccess: true));
  //     }, (error) {
  //       emit(state.copyWith(
  //           errorMessage: 'Failed', isLoading: false, activePage: 0));
  //     });
  //   } catch (e) {
  //     moxyPrint(e);
  //   }
  // }

  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }

  void pickProduct() {
    moxyPrint('pick product');
  }

  void firstNameChanged(value) {
    final String firstName = value;
    emit(state.copyWith(client:state.client.copyWith(firstName: firstName)));
  }
  void secondNameChanged(value) {
    final String secondName = value;
    emit(state.copyWith(client:state.client.copyWith(secondName: secondName)));
  }
  void phoneNumberChanged(value) {
    final int mobileNumber = value;
    emit(state.copyWith(client:state.client.copyWith(mobileNumber: mobileNumber)));
  }

  void updateSelectedStatusTitle(String newSelectedStatusTitle) {
    emit(state.copyWith(status: newSelectedStatusTitle));
  }

  void selectDeliveryType(String type) {
    emit(state.copyWith(deliveryType: type));
  }

  void selectPaymentType(String type) {
    emit(state.copyWith(paymentType: type));
  }


  void moveToNextPage() {
    if (state.activePage != 3) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      // if (validateFields()) {

      // addOrder();
      // }
    }
  }

  void moveToPreviustPage() {
    if (state.activePage != 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void clearState() {
    emit(CreateOrderState.defaultCreateProductState());
  }

  void clearErrorState() {
    emit(state.copyWith(errorMessage: ''));
  }

  // bool validateFields() {
  //   final errors = FieldErrors.noErrors();
  //   var noErrors = true;
  //   if (isFieldEmpty(state.product.name)) {
  //     errors.productName = FieldError.empty;
  //     noErrors = false;
  //   }
  //   if (isFieldEmpty(state.product.description)) {
  //     errors.productDescription = FieldError.empty;
  //     noErrors = false;
  //   }
  //   if (isFieldEmpty(state.product.idName)) {
  //     errors.productIdName = FieldError.empty;
  //     noErrors = false;
  //   }
  //   if (!isValidPrice(state.product.costPrice)) {
  //     errors.costPrice = FieldError.invalid;
  //     noErrors = false;
  //   }
  //   if (!isValidPrice(state.product.salePrice)) {
  //     errors.salePrice = FieldError.invalid;
  //     noErrors = false;
  //   }
  //   if (!noErrors) {
  //     emitEffect(ValidationFailed(errors.formErrorMessageFields()));
  //   }
  //   emit(state.copyWith(errors: errors));
  //   return noErrors;
  // }
}
