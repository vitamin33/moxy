// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/data/repositories/basket_repository.dart';
import 'package:moxy/domain/mappers/basket_mapper.dart';
import 'package:moxy/domain/mappers/city_mapper.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/warehouse.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final basketRepository = locate<BasketRepository>();
  final basketMapper = locate<BasketMapper>();
  final cityMapper = locate<CityMapper>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  CheckoutCubit() : super(CheckoutState.defaultState()) {
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
    if (!checkQuantityAvailability(basketItem)) {
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
    if (!checkQuantityAvailability(basketItem)) {
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
  }

  bool checkQuantityAvailability(BasketItem basketItem) {
    Dimension dimen = basketItem.dimension;
    Dimension currentDimen =
        basketItem.product.dimensions.firstWhere((d) => d.color == dimen.color);
    if (dimen.quantity > 0 && dimen.quantity < currentDimen.quantity) {
      return true;
    }
    return false;
  }

  void updateCart(BasketItem basketItem) async {
    NetworkChangeBasketDimen item =
        basketMapper.mapToNetworkBasketChangeDimen(basketItem);
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
