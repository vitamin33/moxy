import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moxy/constant/order_status.dart';
import 'package:moxy/constants.dart';
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

  CreateOrderCubit() : super(CreateOrderState.defaultCreateProductState()) {
    _subscribe();
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController prePaymentController =
      TextEditingController(text: defaultCashAvanceValue.toString());
  final TextEditingController ukrPostInfoController = TextEditingController();
  final PageController pageController = PageController(initialPage: 0);

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
        state.cashAdvanceValue,
        state.ukrPostInfo,
      );
      final pushOrder = await orderRepository.addOrder(order);
      pushOrder.when((success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        emitEffect(SuccessCreation());
        firstNameController.clear();
        secondNameController.clear();
        phoneNumberController.clear();
        ukrPostInfoController.clear();
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
    final int? cashAdvance = int.tryParse(value);
    emit(state.copyWith(cashAdvanceValue: cashAdvance));
  }

  void ukrPostInfoChanged(value) {
    final String info = value;
    emit(state.copyWith(ukrPostInfo: info));
  }

  void updateSelectedStatus(OrderStatus? selectedStatus) {
    emit(state.copyWith(
        status: state.status.copyWith(statusValue: selectedStatus)));
  }

  void selectDeliveryType(DeliveryType type) {
    emit(state.copyWith(deliveryType: type));
  }

  void selectPaymentType(PaymentType type) {
    emit(state.copyWith(paymentType: type));
    if (type == PaymentType.cashAdvance) {
      emit(state.copyWith(
        cashAdvanceValue: defaultCashAvanceValue,
        status: state.status.copyWith(statusValue: OrderStatus.Reserved),
        availableStatuses: [OrderStatus.Reserved],
      ));
    } else {
      emit(state.copyWith(
        cashAdvanceValue: null,
        status: state.status.copyWith(statusValue: OrderStatus.Paid),
        availableStatuses: [
          OrderStatus.Paid,
          OrderStatus.Sent,
          OrderStatus.Sale,
        ],
      ));
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

  Future<void> pasteUsersData() async {
    final input = await getTextFromClipboard();
    moxyPrint(input);

    String phone = '';
    String firstName = '';
    String secondName = '';
    String city = '';
    String warehouse = '';

    RegExp phoneRegExp = RegExp(r'(\+?\d{12}|\+?\d{9})');
    Iterable<Match> phoneMatches = phoneRegExp.allMatches(input);
    if (phoneMatches.isNotEmpty) {
      phone = phoneMatches.first.group(0)!;
    }

    RegExp nameRegExp =
        RegExp(r'([А-Яа-яЁё]+)\s+([А-Яа-яЁё]+)(\s+[А-Яа-яЁё]+)??');
    ;
    Iterable<Match> nameMatches = nameRegExp.allMatches(input);
    if (nameMatches.isNotEmpty) {
      Match nameMatch = nameMatches.first;
      firstName = nameMatch.group(1)!;
      secondName = nameMatch.group(2)!;
    }

    RegExp cityRegExp =
        RegExp(r'([А-Яа-яЁё]+.*Нової пошти +.*місто +.*м \d+|[А-Яа-яЁё]+)');
    Iterable<Match> cityMatches = cityRegExp.allMatches(input);
    if (cityMatches.isNotEmpty) {
      city = cityMatches.first.group(0)!;
    }

    RegExp warehouseRegExp = RegExp(r'\b\d{1,3}\b');
    Iterable<Match> warehouseMatches = warehouseRegExp.allMatches(input);
    if (warehouseMatches.isNotEmpty) {
      warehouse = warehouseMatches.first.group(0)!;
    }

    firstNameController.text = firstName;
    secondNameController.text = secondName;
    phoneNumberController.text = phone;

    selectCity(City(
        mainDescription: city,
        ref: '',
        deliveryCityRef: '',
        presentName: city));

    selectWarehouse(Warehouse(
        ref: '',
        postMachineType: '',
        description: warehouse,
        number: int.parse(warehouse)));

    emit(state.copyWith(
      client: state.client.copyWith(
          firstName: firstName, secondName: secondName, mobileNumber: phone),
    ));
  }

  Future<String> getTextFromClipboard() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    final text = data?.text ?? '';
    return text;
  }

  bool validateFields() {
    final errors = FieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.client.firstName)) {
      errors.firstName = FieldError.empty;
      noErrors = false;
    }
    if (!isValidCashAdvanceValue(state.cashAdvanceValue, state.status)) {
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
