import '../../ui_effect.dart';

class ENsLoadingFailed implements UiEffect {
  String failureText;
  ENsLoadingFailed(this.failureText);
}

class ApiKeyNotSaved implements UiEffect {}
