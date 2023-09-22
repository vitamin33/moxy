import '../../ui_effect.dart';

class ProfileValidationFailed implements UiEffect {
  String failureText;
  ProfileValidationFailed(this.failureText);
}

class ProfileSuccess implements UiEffect {
   String successText;
   ProfileSuccess(this.successText);
}

class ProfileApiRequestFailed implements UiEffect {
  String failureText;
  ProfileApiRequestFailed(this.failureText);
}