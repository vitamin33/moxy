import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/profile_repository.dart';
import 'package:moxy/domain/client/subscribe/subscribe_effect.dart';
import 'package:moxy/domain/client/subscribe/subscribe_state.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

class SubscribeCubit extends CubitWithEffects<SubscribeState, UiEffect>
    with ValidationMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();

  SubscribeCubit() : super(SubscribeState.defaultSubscribeState());

  final profileRepository = locate<ProfileRepository>();

  void subscribeLead() async {
    try {
      if (validateFields()) {
        emit(state.copyWith(isLoading: true));
        final result =
            await profileRepository.subscribeLead(state.email, state.firstName);
        result.when((success) {
          emit(state.copyWith(isLoading: false, email: '', firstName: ''));
          emitEffect(const SubscribeSuccess());
        }, (error) {
          moxyPrint('$error');
          emit(state.copyWith(isLoading: false));
          emitEffect(SubscribeApiRequestFailed(error.toString()));
        });
      } else {
        emitEffect(SubscribeValidationFailed(
            'Введені поля невалідні, перевірте дані і спробуйте ще'));
      }
    } catch (e) {
      moxyPrint('$e');
      emit(state.copyWith(isLoading: false));
      emitEffect(SubscribeApiRequestFailed(e.toString()));
    }
  }

  void emailChanged(String value) {
    final String userEmail = value;
    emit(state.copyWith(email: userEmail));
  }

  void firstNameChanged(String value) {
    final String name = value;
    emit(state.copyWith(firstName: name));
  }

  bool validateFields() {
    return !(state.email.isEmpty || !validateEmailAddress(state.email));
  }
}
