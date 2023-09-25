import 'dart:async';
import 'package:flutter/material.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/admin/create_order/create_order_effects.dart';
import 'package:moxy/domain/models/dimension_product.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/utils/common.dart';
import '../../../constant/order_constants.dart';
import '../../../data/repositories/order_repository.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../services/get_it.dart';
import '../../mappers/order_mapper.dart';
import '../../models/order.dart';
import '../../models/status.dart';
import '../../models/warehouse.dart';
import '../../ui_effect.dart';
import '../../validation_mixin.dart';
import 'create_order_state.dart';

class CreateOrderCubit extends CubitWithEffects<CreateOrderState, UiEffect>
    with ValidationMixin {
  final orderRepository = locate<OrderRepository>();
  final productRepository = locate<ProductRepository>();
  final orderMapper = locate<OrderMapper>();
  final _productMapper = locate<ProductMapper>();

  late final StreamSubscription _selectedProductSubscription;

  bool isEditMode;

  CreateOrderCubit({this.isEditMode = false})
      : super(
          CreateOrderState(
              isLoading: false,
              isEdit: false,
              isSuccess: false,
              initialPage: 0,
              activePage: 0,
              errors: FieldErrors(),
              deliveryType: DeliveryType.novaPost,
              paymentType: PaymentType.fullPayment,
              novaPostNumber: 0,
              productListPrice: 0,
              selectedProducts: [],
              selectedCity: City.defaultCity(),
              selectedWarehouse: Warehouse.defaultWarehouse(),
              client: Client.defaultClient(),
              status: Status.defaultStatus(),
              prepayment: '0'),
        ) {
    _subscribe();
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController prePaymentController =
      TextEditingController(text: '150');
  final PageController pageController = PageController(initialPage: 0);

  void setEditMode(bool isEdit) {
    isEditMode = isEdit;
  }

  void _subscribe() {
    _selectedProductSubscription = productRepository.selectedProducts.listen(
      (items) {
        final productDimensList =
            _productMapper.mapToProductDimensionList(items);
        final price = fullPrice(productDimensList);
        emit(
          state.copyWith(
              selectedProducts: productDimensList,
              isEdit: true,
              productListPrice: price),
        );
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
      List<OrderedItem> selectedProducts =
          productRepository.currentSelectedProducts ?? [];
      final order = orderMapper.mapToNetworkCreateOrder(
          state.deliveryType,
          state.paymentType,
          selectedProducts,
          state.selectedWarehouse,
          state.client,
          state.selectedCity,
          state.status.statusValue.name,
          state.prepayment);
      final pushOrder = await orderRepository.addOrder(order);
      pushOrder.when((success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        emitEffect(SuccessCreation());
        firstNameController.clear();
        secondNameController.clear();
        phoneNumberController.clear();
      }, (error) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          activePage: 0,
        ));
        emitEffect(FailedCreation(error.toString()));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  int fullPrice(List<DimensionProduct> selectedProducts) {
    int totalPrice = 0;
    for (final product in selectedProducts) {
      totalPrice += (product.salePrice * product.dimension.quantity).toInt();
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

  void prePaymentChanged(String value) {
    if (value.isEmpty) {
      return;
    }
    final String prepayment = value;
    emit(state.copyWith(prepayment: prepayment));
  }

  void updateSelectedStatusTitle(newSelectedStatusTitle) {
    emit(state.copyWith(
        status: state.status.copyWith(statusValue: newSelectedStatusTitle)));
  }

  void selectDeliveryType(DeliveryType type) {
    emit(state.copyWith(deliveryType: type));
  }

  void selectPaymentType(PaymentType type) {
    emit(state.copyWith(paymentType: type));
    if (type.name == 'cashAdvance') {
      emit(state.copyWith(prepayment: '150'));
    } else {
      emit(state.copyWith(prepayment: null));
    }
  }

  void moveToNextPage() {
    if (state.activePage != 3) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      if (validateFields()) {
        addOrder();
      }
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

  void selectCity(City? city) {
    emit(state.copyWith(
        selectedCity: city, selectedWarehouse: Warehouse.defaultWarehouse()));
  }

  void selectWarehouse(Warehouse? warehouse) {
    emit(state.copyWith(selectedWarehouse: warehouse));
  }

  void createNew() {
    emit(state.copyWith(isSuccess: false));
    clearState();
  }

  bool validateFields() {
    final errors = FieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.client.firstName)) {
      errors.firstName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.prepayment)) {
      errors.selectedPrepayment = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.client.secondName)) {
      errors.secondName = FieldError.empty;
      noErrors = false;
    }
    if (!phoneNumberRegExp.hasMatch(state.client.mobileNumber)) {
      errors.phoneNumber = FieldError.invalid;
      noErrors = false;
    }
    if (!isValidSelectedProduct(state.selectedProducts)) {
      errors.selectedProduct = FieldError.invalid;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(ValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(errors: errors));
    return noErrors;
  }
}
