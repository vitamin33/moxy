import '../../ui_effect.dart';

class ValidationFailed implements UiEffect {
  String failureText;
  ValidationFailed(this.failureText);
}

class NavigateToPaymentProccess implements UiEffect {
  Uri paymentUri;
  NavigateToPaymentProccess(this.paymentUri);
}

class UnableToLoadPaymentUrl implements UiEffect {}

class NewOrderCreationFailed implements UiEffect {}
