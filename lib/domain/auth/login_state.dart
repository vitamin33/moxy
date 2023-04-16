import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default('') String email,
    @Default('') String password,
    @Default(AuthState()) AuthState state,
  }) = _Initial;

  const LoginState._();

  bool get emailIsValid =>
      email.trim().isNotEmpty && email.trim().contains("@");
}

class AuthState {
  const AuthState();
}

class Loading extends AuthState {
  Loading();
}

class LoginWithCredsSuccess extends AuthState {
  LoginWithCredsSuccess();
}

class Logout extends AuthState {
  Logout();
}

class LogoutFailed extends AuthState {
  LogoutFailed();
}

class LoginFailed extends AuthState {
  LoginFailed({
    required this.message,
  });

  String? errorCode;
  final String message;
}
