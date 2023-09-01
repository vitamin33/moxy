// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:moxy/data/repositories/footer_repository.dart';
import 'package:moxy/domain/client/footer/footer_state.dart';
import 'package:moxy/domain/ui_effect.dart';

import '../../../services/cubit_with_effects.dart';
import '../../../services/get_it.dart';
import '../../../utils/common.dart';

class FooterCubit extends CubitWithEffects<FooterState, UiEffect> {
  FooterCubit() : super(FooterState.defaultFooterState());

  final footerRepository = locate<FooterRepository>();

  final TextEditingController userEmailController = TextEditingController();

  void emailChanged(value) {
    final String userEmail = value;
    emit(state.copyWith(userEmail: userEmail));
  }

  void sendEmail() async {
    try {
      final result =
          await footerRepository.sendFooterUserEmail(state.userEmail);
      result.when((success) {
        userEmailController.clear();
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed send client email'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
