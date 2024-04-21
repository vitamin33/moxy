// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/promo_repository.dart';
import 'package:moxy/domain/client/promo/promo_state.dart';
import 'package:moxy/services/get_it.dart';

import '../../../utils/common.dart';
import '../../mappers/promo_mapper.dart';

class PromoCubit extends Cubit<PromoState> {
  PromoCubit() : super(PromoState.defaultPromoState()) {
    allPromo();
  }

  final promoRepository = locate<PromoRepository>();
  final promoMapper = locate<PromoMapper>();

  final pageController = PageController(initialPage: 0);

  void onChangePage(page) {
    emit(state.copyWith(activePage: page));
  }

  void moveToPreviustPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void moveToNextPage() {
    double currentIndex = 0;
    if (pageController.hasClients) {
      currentIndex = pageController.page ?? 0;
    }
    if (currentIndex < state.allPromo.length - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      animatedToPage(0);
    }
  }

  void animatedToPage(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void allPromo() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await promoRepository.getPromo();
      result.when((success) {
        final mappedPromo = promoMapper.mapToPromo(success);
        emit(state.copyWith(allPromo: mappedPromo, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed getAllPromos'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
