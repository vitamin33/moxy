import '../../ui_effect.dart';

class SubscribeApiRequestFailed implements UiEffect {
  String failureText;
  SubscribeApiRequestFailed(this.failureText);
}

class SubscribeValidationFailed implements UiEffect {
  String failureText;
  SubscribeValidationFailed(this.failureText);
}

class SubscribeSuccess implements UiEffect {
  const SubscribeSuccess();
}
