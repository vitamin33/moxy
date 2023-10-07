import 'package:moxy/domain/copyable.dart';

class RegistrationState implements Copyable<RegistrationState> {
  final String firstName;
  final String secondName;
  final String mobileNumber;
  final String email;
  final String password;
  final String confirmationCode;
  final String mobileNumberPassword;
  final String newPassword;
  final String confirmPassword;
  final RegisterState state;

  RegistrationState({
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.confirmationCode,
    required this.mobileNumberPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.state,
  });

  static RegistrationState defaultAllProductsState() {
    return RegistrationState(
      firstName: '',
      secondName: '',
      email: '',
      mobileNumber: '',
      password: '',
      confirmationCode: '',
      mobileNumberPassword: '',
      newPassword: '',
      confirmPassword: '',
      state: const RegisterState(),
    );
  }

  @override
  RegistrationState copyWith({
    String? firstName,
    String? secondName,
    String? email,
    String? mobileNumber,
    String? password,
    String? confirmationCode,
    String? mobileNumberPassword,
    String? newPassword,
    String? confirmPassword,
    RegisterState? state,
  }) {
    return RegistrationState(
        firstName: firstName ?? this.firstName,
        secondName: secondName ?? this.secondName,
        email: email ?? this.email,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        password: password ?? this.password,
        confirmationCode: confirmationCode ?? this.confirmationCode,
        mobileNumberPassword: mobileNumberPassword ?? this.mobileNumberPassword,
        newPassword: newPassword ?? this.newPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
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
