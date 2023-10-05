import 'package:moxy/domain/copyable.dart';

class RegistrationState implements Copyable<RegistrationState> {
  final String name;
  final String mobileNumber;
  final String email;
  final String password;
  final String verCode;
  final RegisterState state;

  RegistrationState({
    required this.name,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.verCode,
    required this.state,
  });

  static RegistrationState defaultAllProductsState() {
    return RegistrationState(
      name: '',
      email: '',
      mobileNumber: '',
      password: '',
      verCode: '',
      state: const RegisterState(),
    );
  }

  @override
  RegistrationState copyWith({
    String? name,
    String? email,
    String? mobileNumber,
    String? password,
    String? verCode,
    RegisterState? state,
  }) {
    return RegistrationState(
        name: name ?? this.name,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        password: password ?? this.password,
        verCode: verCode ?? this.verCode,
        state: state ?? this.state);
  }

  bool get mobileNumberIsValid => mobileNumber.length > 9;
}

class RegisterState {
  const RegisterState();
}

class Loading extends RegisterState {
  Loading();
}

class Register extends RegisterState {
  Register();
}

class RegisterFailed extends RegisterState {
  RegisterFailed({
    required this.message,
  });

  String? errorCode;
  final String message;
}
