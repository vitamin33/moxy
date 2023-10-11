// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/data/repositories/basket_repository.dart';
import 'package:moxy/domain/admin/create_order/create_order_effects.dart';
import 'package:moxy/domain/mappers/basket_mapper.dart';
import 'package:moxy/domain/mappers/city_mapper.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/warehouse.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'checkout_state.dart';

class CheckoutCubit extends CubitWithEffects<CheckoutState, UiEffect>
    with ValidationMixin {
  final basketRepository = locate<BasketRepository>();
  final basketMapper = locate<BasketMapper>();
  final cityMapper = locate<CityMapper>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  CheckoutCubit(Basket basket) : super(CheckoutState.defaultState()) {
    updateStateBasket(basket);
    getBasketInfo();
  }

  void getBasketInfo() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await basketRepository.getBasket();
      result.when((success) {
        emitSuccessBasket(success);
      }, (error) {
        emit(state.copyWith(basketProductsError: 'Failed get basket info'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void selectCity(City? city) {
    emit(state.copyWith(
        selectedCity: city, selectedWarehouse: Warehouse.defaultWarehouse()));
  }

  void selectWarehouse(Warehouse? warehouse) {
    emit(state.copyWith(selectedWarehouse: warehouse));
  }

  void changePayment(PaymentType type) {
    emit(state.copyWith(paymentType: type));
  }

  void changeDelivery(DeliveryType type) {
    emit(state.copyWith(deliveryType: type));
  }

  void addQuantityOfProduct(BasketItem basketItem) {
    if (!checkMaxQuantityAvailability(basketItem)) {
      return;
    }
    String? productId = basketItem.product.id;
    BasketItem item = state.basket.basketItems
        .firstWhere((element) => element.product.id == productId);
    basketItem.dimension.quantity++;
    item.dimension = basketItem.dimension;
    emit(
      state.copyWith(
        basket: state.basket.copyWith(basketItems: state.basket.basketItems),
      ),
    );
    updateCart(item);
  }

  void removeQuantityOfProduct(BasketItem basketItem) {
    if (!checkMinQuantityAvailability(basketItem)) {
      return;
    }
    String? productId = basketItem.product.id;
    BasketItem item = state.basket.basketItems
        .firstWhere((element) => element.product.id == productId);
    basketItem.dimension.quantity--;
    item.dimension = basketItem.dimension;
    emit(
      state.copyWith(
        basket: state.basket.copyWith(basketItems: state.basket.basketItems),
      ),
    );
    updateCart(item);
  }

  void removeProductFromBasket(BasketItem item) {
    List<BasketItem> items = state.basket.basketItems;
    items.removeWhere((element) => element.product.id == item.product.id);
    emit(state.copyWith(basket: state.basket.copyWith(basketItems: items)));
    removeProductFromCart(item);
  }

  bool checkMaxQuantityAvailability(BasketItem basketItem) {
    Dimension dimen = basketItem.dimension;
    Dimension currentDimen =
        basketItem.product.dimensions.firstWhere((d) => d.color == dimen.color);
    if (dimen.quantity < currentDimen.quantity) {
      return true;
    }
    return false;
  }

  bool checkMinQuantityAvailability(BasketItem basketItem) {
    if (basketItem.dimension.quantity > 1) {
      return true;
    }
    return false;
  }

  void updateCart(BasketItem basketItem) async {
    NetworkAddOrChange item = basketMapper.mapToNetworkBasketChange(basketItem);
    final result = await basketRepository.changeBasketProductDimen(item);
    result.when((success) {
      emitSuccessBasket(success);
    }, (error) {
      emit(state.copyWith(basketProductsError: 'Failed get basket info'));
    });
  }

  void removeProductFromCart(BasketItem basketItem) async {
    NetworkRemoveProduct remove =
        NetworkRemoveProduct(productId: basketItem.product.id!);
    final result = await basketRepository.removeProductFromBasket(remove);
    result.when((success) {
      emitSuccessBasket(success);
    }, (error) {
      emit(state.copyWith(basketProductsError: 'Failed get basket info'));
    });
  }

  void emitSuccessBasket(NetworkBasket success) {
    Basket basket = basketMapper.mapToBasket(success);
    updateStateBasket(basket);
  }

  void firstNameChanged(String value) {
    final String firstName = value;
    emit(state.copyWith(client: state.client.copyWith(firstName: firstName)));
  }

  void secondNameChanged(String value) {
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

  void clickCheckout() async {
    if (!validateFields()) {
      return;
    }
    final result = await basketRepository.startPayment();
    result.when((success) {
      // TODO update UI with success
    }, (error) {
      emit(state.copyWith(basketProductsError: 'Failed to perform checkout'));
    });
  }

  bool validateFields() {
    final errors = FieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.client.firstName)) {
      errors.firstName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.selectedCity.presentName)) {
      errors.selectedCity = FieldError.empty;
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
    if (!isFieldEmpty(state.selectedWarehouse.ref)) {
      errors.selectedWarehouse = FieldError.empty;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(ValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(errors: errors));
    return noErrors;
  }

  void updateStateBasket(Basket basket) {
    bool isFreeShipping =
        basket.amountForFreeShipping() > basket.freeShippingThreshold;
    emit(
      state.copyWith(
        basket: basket,
        isFreeShipping: isFreeShipping,
        isLoading: false,
      ),
    );
  }
}
