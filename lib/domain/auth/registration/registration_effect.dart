import '../../ui_effect.dart';

class RegistrationValidationFailed implements UiEffect {
  String failureText;
  RegistrationValidationFailed(this.failureText);
}

class RegistrationApiRequestFailed implements UiEffect {
  String failureText;
  RegistrationApiRequestFailed(this.failureText);
}

class NavigateToLogin implements UiEffect {}

class RegisterSuccess implements UiEffect {}

class ResendConfirm implements UiEffect {}

class NoResetTokenFound implements UiEffect {}

class ResetEmailFailed implements UiEffect {}
