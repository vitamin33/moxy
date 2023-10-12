import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/validation_mixin.dart';

class RegistrationState implements Copyable<RegistrationState> {
  final String firstName;
  final String secondName;
  final String mobileNumber;
  final String email;
  final String password;
  final String confirmRegisterPassword;
  final String confirmationCode;
  final String mobileNumberPassword;
  final String newPassword;
  final String confirmPassword;
  final RegisterState state;
  final RegisterFieldErrors error;

  RegistrationState({
    required this.firstName,
    required this.secondName,
    required this.mobileNumber,
    required this.email,
    required this.password,
    required this.confirmRegisterPassword,
    required this.confirmationCode,
    required this.mobileNumberPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.state,
    required this.error,
  });

  static RegistrationState defaultAllProductsState() {
    return RegistrationState(
      firstName: '',
      secondName: '',
      email: '',
      mobileNumber: '',
      password: '',
      confirmRegisterPassword: '',
      confirmationCode: '',
      mobileNumberPassword: '',
      newPassword: '',
      confirmPassword: '',
      state: const RegisterState(),
      error: RegisterFieldErrors(),
    );
  }

  @override
  RegistrationState copyWith({
    String? firstName,
    String? secondName,
    String? email,
    String? mobileNumber,
    String? password,
    String? confirmRegisterPassword,
    String? confirmationCode,
    String? mobileNumberPassword,
    String? newPassword,
    String? confirmPassword,
    RegisterState? state,
    RegisterFieldErrors? error,
  }) {
    return RegistrationState(
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      password: password ?? this.password,
      confirmRegisterPassword:
          confirmRegisterPassword ?? this.confirmRegisterPassword,
      confirmationCode: confirmationCode ?? this.confirmationCode,
      mobileNumberPassword: mobileNumberPassword ?? this.mobileNumberPassword,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      state: state ?? this.state,
      error: error ?? this.error,
    );
  }
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

class RegisterFieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? email;
  FieldError? mobileNumber;
  FieldError? password;
  FieldError? confirmRegisterPassword;
  FieldError? confirmationCode;
  FieldError? mobileNumberPassword;
  FieldError? newPassword;
  FieldError? confirmPassword;

  RegisterFieldErrors({
    this.firstName,
    this.secondName,
    this.email,
    this.mobileNumber,
    this.password,
    this.confirmRegisterPassword,
    this.confirmationCode,
    this.mobileNumberPassword,
    this.newPassword,
    this.confirmPassword,
  });

  static RegisterFieldErrors noErrors() {
    return RegisterFieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (firstName != null) {
      buffer.write('firstName');
    }
    if (email != null) {
      buffer.write('email');
    }
    if (mobileNumber != null) {
      buffer.write('mobileNumber');
    }
    if (password != null) {
      buffer.write('password');
    }
    if (confirmRegisterPassword != null) {
      buffer.write('confirmRegisterPassword');
    }
    if (confirmationCode != null) {
      buffer.write('confirmationCode');
    }
    if (mobileNumberPassword != null) {
      buffer.write('mobileNumberPassword');
    }
    if (newPassword != null) {
      buffer.write('newPassword');
    }
    if (confirmPassword != null) {
      buffer.write('confirmPassword');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
