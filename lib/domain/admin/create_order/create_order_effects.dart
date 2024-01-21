import '../../ui_effect.dart';

class ValidationFailed implements UiEffect {
  String failureText;
  ValidationFailed(this.failureText);
}

class SuccessCreation implements UiEffect {}

class FailedCreation implements UiEffect {
  String reason;
  FailedCreation(this.reason);
}

class NavigateToNovaPostENs implements UiEffect {}
