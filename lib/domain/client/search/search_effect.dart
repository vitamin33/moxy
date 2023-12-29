import '../../ui_effect.dart';

class SearchValidationFailed implements UiEffect {
  String failureText;
  SearchValidationFailed(this.failureText);
}

class SearchApiRequestFailed implements UiEffect {
  String failureText;
  SearchApiRequestFailed(this.failureText);
}