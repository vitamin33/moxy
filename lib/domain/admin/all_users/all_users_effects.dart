import '../ui_effect.dart';

class UsersLoadingFailed implements UiEffect {
  String failureText;
  UsersLoadingFailed(this.failureText);
}
