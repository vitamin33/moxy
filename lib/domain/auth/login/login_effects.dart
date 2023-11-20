import '../../ui_effect.dart';

class LoginFailed implements UiEffect {
  String failureText;
  LoginFailed(this.failureText);
}

class NavigateToClient implements UiEffect {}

class NavigateToAdmin implements UiEffect {}
