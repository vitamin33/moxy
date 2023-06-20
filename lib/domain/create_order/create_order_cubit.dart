import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/utils/common.dart';

import '../../constant/order_constants.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../services/get_it.dart';
import '../../services/navigation_service.dart';
import '../mappers/order_mapper.dart';
import '../models/product.dart';
import '../ui_effect.dart';
import '../validation_mixin.dart';
import 'create_order_state.dart';

class CreateOrderCubit extends CubitWithEffects<CreateOrderState, UiEffect>
    with ValidationMixin {
  final orderMapper = locate<OrderMapper>();
  final orderRepository = locate<OrderRepository>();
  final productRepository = locate<ProductRepository>();
  final navigationService = locate<NavigationService>();

  late final StreamSubscription _selectedProductSubscription;

  bool isEditMode;

  CreateOrderCubit({this.isEditMode = false})
      : super(CreateOrderState.defaultCreateProductState()) {
    _subscribe();
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);

  void setEditMode(bool isEdit) {
    isEditMode = isEdit;
  }

  void _subscribe() {
    _selectedProductSubscription = productRepository.selectedProducts.listen(
      (items) {
        final totalPrice = fullPrice(items);
        final selectedItems = orderMapper.mapProductsToOrderedItemList(items);
        emit(state.copyWith(
            selectedProducts: selectedItems,
            productListPrice: totalPrice,
            isEdit: true));
      },
      onError: (error) =>
          {moxyPrint('Error during selected products listening.')},
    );
  }

  @override
  Future<void> close() {
    _selectedProductSubscription.cancel();
    moxyPrint('Cubit closed');
    return super.close();
  }

  void addOrder() async {
    try {
      emit(state.copyWith(isLoading: true));

      // TODO here should be validation in order to have all needed data
      // before creating order - like state.selectedCity should't be null

      final order = orderMapper.mapToNetworkCreateOrder(
          state.deliveryType,
          state.paymentType,
          state.selectedProducts,
          state.client,
          state.selectedCity!,
          state.status);
      final pushProduct = await orderRepository.addOrder(order);
      pushProduct.when((success) {
        emit(state.copyWith(isLoading: false));
        firstNameController.clear();
        secondNameController.clear();
        phoneNumberController.clear();
        emit(state.copyWith(isSuccess: true, isLoading: false));
      }, (error) {
        emit(state.copyWith(
            errorMessage: 'Failed', isLoading: false, activePage: 0));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  int fullPrice(List<Product> selectProduct) {
    int totalPrice = 0;
    for (final product in selectProduct) {
      for (final dimension in product.dimensions) {
        totalPrice += product.costPrice.toInt() * dimension.quantity;
      }
    }
    return totalPrice;
  }

  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }

  void pickProduct() {
    moxyPrint('pick product');
  }

  void firstNameChanged(value) {
    final String firstName = value;
    emit(state.copyWith(client: state.client.copyWith(firstName: firstName)));
  }

  void secondNameChanged(value) {
    final String secondName = value;
    emit(state.copyWith(client: state.client.copyWith(secondName: secondName)));
  }

  void phoneNumberChanged(String value) {
    if (value.isEmpty) {
      return;
    }
    final String mobileNumber = value;
    emit(state.copyWith(
        client: state.client.copyWith(mobileNumber: mobileNumber)));
  }

  void updateSelectedStatusTitle(String newSelectedStatusTitle) {
    emit(state.copyWith(status: newSelectedStatusTitle));
  }

  void selectDeliveryType(DeliveryType type) {
    emit(state.copyWith(deliveryType: type));
  }

  void selectPaymentType(PaymentType type) {
    emit(state.copyWith(paymentType: type));
  }

  void moveToNextPage() {
    if (state.activePage != 3) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      addOrder();
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

  void selectCity(City? city) {
    emit(state.copyWith(selectedCity: city));
  }
}
