import '../ui_effect.dart';

class UserValidationFailed implements UiEffect {
  String failureText;
  UserValidationFailed(this.failureText);
}

class UserCreatedSuccess implements UiEffect {
  const UserCreatedSuccess();
}

class DataParseFailed implements UiEffect {
  const DataParseFailed();
}
