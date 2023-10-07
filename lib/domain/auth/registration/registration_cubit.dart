import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/services/get_it.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final authRepository = locate<AuthRepository>();

  RegistrationCubit()
      : super(RegistrationState(
            mobileNumber: '',
            firstName: '',
            secondName: '',
            email: '',
            password: '',
            confirmationCode: '',
            mobileNumberPassword: '',
            newPassword: '',
            confirmPassword: '',
            state: const RegisterState())) {
    emit(state.copyWith(mobileNumber: '0938795984', password: '123123'));
  }

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController mobileNumberPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void firstNameChanged(String value) {
    final firstName = value;
    emit(state.copyWith(
      firstName: firstName,
    ));
  }
  void secondNameChanged(String value) {
    final secondName = value;
    emit(state.copyWith(
      secondName: secondName,
    ));
  }

  void mobileNumberChanged(String value) {
    final mobileNumber = value;
    emit(state.copyWith(
      mobileNumber: mobileNumber,
    ));
  }

  void emailChanged(String value) {
    final email = value;
    emit(state.copyWith(
      email: email,
    ));
  }

  void passwordChanged(String value) {
    final password = value;
    emit(state.copyWith(
      password: password,
    ));
  }

  void changeVarCode(String value) {
    final confirmationCode = value;
    emit(state.copyWith(
      confirmationCode: confirmationCode,
    ));
  }

  void register(context) async {
    try {
      emit(state.copyWith(state: Loading()));

      final result = await authRepository.register(
          state.firstName,state.secondName, state.mobileNumber, state.email, state.password);

      result.when((role) {
                    context.read<LoginCubit>().nextPage();

      }, (error) {
        emit(state.copyWith(
            state: RegisterFailed(
                message: 'Unable to login. Try one more time.')));
      });
    } on Exception catch (error) {
      emit(state.copyWith(state: RegisterFailed(message: error.toString())));
    }
  }

  void sendConfirmationCode() async {
    try {
      emit(state.copyWith(state: Loading()));
      final result = await authRepository.sendConfirmationCode(state.confirmationCode,state.email);
      result.when((role) {}, (error) {
        emit(state.copyWith(
            state: RegisterFailed(
                message: 'Unable to login. Try one more time.')));
      });
    } on Exception catch (error) {
      emit(state.copyWith(state: RegisterFailed(message: error.toString())));
    }
  }

  
  void resendConfirmationCode() async {
    try {
      emit(state.copyWith(state: Loading()));
      final result = await authRepository.resendConfirmationCode(state.email);
      result.when((role) {
        
      }, (error) {
        emit(state.copyWith(
            state: RegisterFailed(
                message: 'Unable to login. Try one more time.')));
      });
    } on Exception catch (error) {
      emit(state.copyWith(state: RegisterFailed(message: error.toString())));
    }
  }

  void mobileNumberPasswordChanged(String value) {
    final mobileNumberPassword = value;
    emit(state.copyWith(
      mobileNumberPassword: mobileNumberPassword,
    ));
  }

  void newPasswordChanged(String value) {
    final newPassword = value;
    emit(state.copyWith(
      newPassword: newPassword,
    ));
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = value;
    emit(state.copyWith(
      confirmPassword: confirmPassword,
    ));
  }
}
