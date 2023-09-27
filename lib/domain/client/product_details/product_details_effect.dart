import '../../ui_effect.dart';

class ValidationFailed implements UiEffect {
  String failureText;
  ValidationFailed(this.failureText);
}
class ProductDetailsSuccess implements UiEffect {
   String successText;
   ProductDetailsSuccess(this.successText);
}

class ProductDetailsApiRequestFailed implements UiEffect {
  String failureText;
  ProductDetailsApiRequestFailed(this.failureText);
}