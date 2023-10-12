import 'package:moxy/domain/roles.dart';

import '../copyable.dart';

class LoginState implements Copyable<LoginState> {
  final String mobileNumber;
  final String password;
  final int activePage;
  final AuthState state;

  LoginState({
    required this.mobileNumber,
    required this.password,
    required this.activePage,
    required this.state,
  });

  static LoginState defaultAllProductsState() {
    return LoginState(
      mobileNumber: '',
      password: '',
      activePage: 0,
      state: const AuthState(),
    );
  }

  @override
  LoginState copyWith({
    String? mobileNumber,
    String? password,
    int? activePage,
    AuthState? state,
  }) {
    return LoginState(
        mobileNumber: mobileNumber ?? this.mobileNumber,
        password: password ?? this.password,
        activePage: activePage ?? this.activePage,
        state: state ?? this.state);
  }

  bool get mobileNumberIsValid => mobileNumber.length > 9;
}

class AuthState {
  const AuthState();
}

class Loading extends AuthState {
  Loading();
}

class LoginWithCredsSuccess extends AuthState {
  LoginWithCredsSuccess({required this.role});

  Role role;
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
