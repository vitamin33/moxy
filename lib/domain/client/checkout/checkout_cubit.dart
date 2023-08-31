// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/basket_repository.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  final basketRepository = locate<BasketRepository>();
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
        emit(state.copyWith(basketProducts: success, isLoading: false));
      }, (error) {
        emit(state.copyWith(basketProductsError: 'Failed get basket info'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
