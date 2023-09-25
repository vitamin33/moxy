import '../../ui_effect.dart';

class ValidationFailed implements UiEffect {
  String failureText;
  ValidationFailed(this.failureText);
}

class BasketApiRequestFailed implements UiEffect {
  String failureText;
  BasketApiRequestFailed(this.failureText);
}