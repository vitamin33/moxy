import '../../ui_effect.dart';

class RegistrationValidationFailed implements UiEffect {
  String failureText;
  RegistrationValidationFailed(this.failureText);
}

class RegistrationApiRequestFailed implements UiEffect {
  String failureText;
  RegistrationApiRequestFailed(this.failureText);
}

class NavigateToNextPage implements UiEffect {}

class NavigateToLogin implements UiEffect {}

class ResendConfirm implements UiEffect {}