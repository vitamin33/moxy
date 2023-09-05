// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/repositories/basket_repository.dart';
import 'package:moxy/domain/mappers/basket_mapper.dart';
import 'package:moxy/domain/mappers/city_mapper.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/warehouse.dart';
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
        emit(
          state.copyWith(
            basket: basketMapper.mapToBasket(success),
            isLoading: false,
          ),
        );
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
}
