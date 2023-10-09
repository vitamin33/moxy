import '../../ui_effect.dart';

class ValidationFailed implements UiEffect {
  String failureText;
  ValidationFailed(this.failureText);
}

class ProductUpdateFailed implements UiEffect {
  String failureText;
  ProductUpdateFailed(this.failureText);
}

class NavigateToProducts implements UiEffect {}
