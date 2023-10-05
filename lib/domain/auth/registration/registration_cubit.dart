import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/services/get_it.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final authRepository = locate<AuthRepository>();

  late TextEditingController phoneController;
  late TextEditingController passwordController;
  String walletConnectURI = '';

  RegistrationCubit()
      : super(RegistrationState(
            mobileNumber: '',
            name: '',
            email: '',
            password: '',
            verCode: '',
            state: const RegisterState())) {
    emit(state.copyWith(mobileNumber: '0938795984', password: '123123'));
  }

  void mobileNumberChanged(String value) {
    final email = value;
    emit(state.copyWith(
      mobileNumber: email,
    ));
  }

  void passwordChanged(String value) {
    final password = value;
    emit(state.copyWith(
      password: password,
    ));
  }

  void changeVarCode(String value) {
    final verCode = value;
    emit(state.copyWith(
      verCode: verCode,
    ));
  }

  void sendVerCode() async {
    try {
      emit(state.copyWith(state: Loading()));

      final result = await authRepository.sendVerCode(state.verCode);

      result.when((role) {}, (error) {
        emit(state.copyWith(
            state: RegisterFailed(
                message: 'Unable to login. Try one more time.')));
      });
    } on Exception catch (error) {
      emit(state.copyWith(state: RegisterFailed(message: error.toString())));
    }
  }
}
