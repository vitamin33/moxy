import '../copyable.dart';

class LoginState implements Copyable<LoginState> {
  final String email;
  final String password;
  final AuthState state;

  LoginState({
    required this.email,
    required this.password,
    required this.state,
  });

  static LoginState defaultAllProductsState() {
    return LoginState(
      email: '',
      password: '',
      state: const AuthState(),
    );
  }

  @override
  LoginState copyWith({
    String? email,
    String? password,
    AuthState? state,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        state: state ?? this.state);
  }

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
