// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/promo_repository.dart';
import 'package:moxy/domain/client/promo/promo_state.dart';
import 'package:moxy/services/get_it.dart';

import '../../../utils/common.dart';

class PromoCubit extends Cubit<PromoState> {
  PromoCubit() : super(PromoState.defaultPromoState()) {
    allPromo();
  }
  final promoRepository = locate<PromoRepository>();

  final pageController = PageController();

  void onChangePage() {}

  void allPromo() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await promoRepository.getPromo();
      result.when((success) {
        emit(state.copyWith(allPromo: success, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
