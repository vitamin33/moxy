import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/domain/auth/registration/registration_effect.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';

class RegistrationCubit extends CubitWithEffects<RegistrationState, UiEffect>
    with ValidationMixin {
  final authRepository = locate<AuthRepository>();

  RegistrationCubit() : super(RegistrationState.defaultRegisterState());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController resetPasswordEmailController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmRegisterPasswordController =
      TextEditingController();
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

  void confirmRegisterPasswordChanged(String value) {
    final confirmRegisterPassword = value;
    emit(state.copyWith(
      confirmRegisterPassword: confirmRegisterPassword,
    ));
  }

  void changeVarCode(String value) {
    final confirmationCode = value;
    emit(state.copyWith(
      confirmationCode: confirmationCode,
    ));
  }

  void register() async {
    try {
      emit(state.copyWith(state: Loading()));
      final result = await authRepository.register(state.firstName,
          state.secondName, state.mobileNumber, state.email, state.password);
      result.when((success) {
        emitEffect(NavigateToVerification());
        emitEffect(RegisterSuccess());
        emit(state.copyWith(state: Register()));
      }, (error) {
        emitEffect(RegistrationApiRequestFailed(error));
        emit(state.copyWith(state: RegisterFailed(message: error)));
      });
    } catch (error) {
      emitEffect(RegistrationApiRequestFailed(error.toString()));
      emit(state.copyWith(state: RegisterFailed(message: error.toString())));
    }
  }

  void sendConfirmationCode() async {
    try {
      emit(state.copyWith(state: Loading()));
      final result = await authRepository.sendConfirmationCode(
          state.confirmationCode, state.email);
      if (result.isSuccess()) {
        emitEffect(NavigateToLogin());
      } else {
        emit(state.copyWith(
            state: RegisterFailed(
                message: 'Unable to login. Try one more time.')));
      }
    } catch (error) {
      emitEffect(RegistrationApiRequestFailed(error.toString()));
      emit(state.copyWith(state: RegisterFailed(message: error.toString())));
    }
  }

  void resendConfirmationCode() async {
    try {
      emit(state.copyWith(state: Loading()));
      final result = await authRepository.resendConfirmationCode(state.email);
      if (result.isSuccess()) {
        emitEffect(ResendConfirm());
      } else {
        emit(state.copyWith(
            state: RegisterFailed(
                message: 'Unable to login. Try one more time.')));
      }
    } catch (error) {
      emitEffect(RegistrationApiRequestFailed(error.toString()));
      emit(state.copyWith(state: RegisterFailed(message: error.toString())));
    }
  }

  void emailPasswordChanged(String value) {
    final emailPassword = value;
    emit(state.copyWith(
      emailForResetPassword: emailPassword,
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

  void createNewPassword() async {
    try {
      if (state.resetToken == null) {
        emitEffect(NoResetTokenFound());
        return;
      }
      emit(state.copyWith(state: Loading()));
      final result = await authRepository.createNewPassword(
        state.emailForResetPassword,
        state.confirmPassword,
        state.resetToken!,
      );
      if (result.isSuccess()) {
        emitEffect(NavigateToLogin());
      } else {
        emit(state.copyWith(
            state: RegisterFailed(
                message: 'Unable to login. Try one more time.')));
      }
    } catch (error) {
      emitEffect(RegistrationApiRequestFailed(error.toString()));
      emit(state.copyWith(state: RegisterFailed(message: error.toString())));
    }
  }

  bool validateRegisterFields() {
    final errors = RegisterFieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.firstName)) {
      errors.firstName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.secondName)) {
      errors.secondName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.email)) {
      errors.email = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.mobileNumber)) {
      errors.mobileNumber = FieldError.invalid;
      noErrors = false;
    }
    if (isFieldEmpty(state.password)) {
      errors.password = FieldError.invalid;
      noErrors = false;
    }
    if (!validateEmailAddress(state.email)) {
      errors.email = FieldError.invalid;
      noErrors = false;
      emit(state.copyWith(error: errors));
      emitEffect(RegistrationValidationFailed(
          'E-mail невалідний перевірте та спробуйте знову.'));
      return noErrors;
    }
    if (!isValidMobileNumber(state.mobileNumber)) {
      errors.mobileNumber = FieldError.invalid;
      noErrors = false;
      emit(state.copyWith(error: errors));
      emitEffect(RegistrationValidationFailed(
          'Номер телефону невалідний перевірте та спробуйте знову.'));
      return noErrors;
    }
    if (!isValidPassword(state.password)) {
      errors.password = FieldError.invalid;
      noErrors = false;
      emit(state.copyWith(error: errors));
      emitEffect(RegistrationValidationFailed(
          'Пароль має бути хоча б 6 символів в довжину.'));
      return noErrors;
    }
    if (!validateRepeatPassword(
        state.password, state.confirmRegisterPassword)) {
      errors.confirmRegisterPassword = FieldError.invalid;
      noErrors = false;
      emit(state.copyWith(error: errors));
      emitEffect(RegistrationValidationFailed(
          'Пароль та підтвердження пароля мають бути однакові.'));
      return noErrors;
    }
    if (!noErrors) {
      emitEffect(RegistrationValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(error: errors));
    return noErrors;
  }

  bool validateConfirmCodeFields() {
    final errors = RegisterFieldErrors.noErrors();
    var noErrors = true;

    if (isFieldEmpty(state.confirmationCode)) {
      errors.confirmationCode = FieldError.invalid;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(RegistrationValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(error: errors));
    return noErrors;
  }

  bool validateChangePasswordFields() {
    final errors = RegisterFieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.emailForResetPassword)) {
      errors.resetPasswordEmail = FieldError.invalid;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(RegistrationValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(error: errors));
    return noErrors;
  }

  bool validateNewPasswordFields() {
    final errors = RegisterFieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.newPassword)) {
      errors.newPassword = FieldError.invalid;
      noErrors = false;
    }
    if (!validateRepeatPassword(state.newPassword, state.confirmPassword)) {
      errors.confirmPassword = FieldError.invalid;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(RegistrationValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(error: errors));
    return noErrors;
  }

  void sendResetEmail() async {
    if (validateChangePasswordFields()) {
      final result =
          await authRepository.resetPassword(state.emailForResetPassword);
      if (result.isSuccess()) {
        emit(state.copyWith(isResetEmailSent: true));
      } else {
        emitEffect(ResetEmailFailed());
      }
    }
  }

  void clearResetState() {
    emit(state.copyWith(isResetEmailSent: false));
  }

  void initNewPasswordFlow(String? email, String? resetToken) {
    emit(state.copyWith(emailForResetPassword: email, resetToken: resetToken));
  }
}
