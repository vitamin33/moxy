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
  final String emailForResetPassword;
  final bool isResetEmailSent;
  final String? resetToken;
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
    required this.emailForResetPassword,
    required this.resetToken,
    required this.isResetEmailSent,
    required this.newPassword,
    required this.confirmPassword,
    required this.state,
    required this.error,
  });

  static RegistrationState defaultRegisterState() {
    return RegistrationState(
      firstName: '',
      secondName: '',
      email: '',
      mobileNumber: '',
      password: '',
      confirmRegisterPassword: '',
      confirmationCode: '',
      emailForResetPassword: '',
      isResetEmailSent: false,
      resetToken: null,
      newPassword: '',
      confirmPassword: '',
      state: const RegisterState(),
      error: RegisterFieldErrors(),
    );
  }

  @override
  RegistrationState copyWith({
    // register
    String? firstName,
    String? secondName,
    String? email,
    String? mobileNumber,
    String? password,
    String? confirmRegisterPassword,
    String? confirmationCode,

    // reset and new pasword
    bool? isResetEmailSent,
    String? emailForResetPassword,
    String? resetToken,
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
      emailForResetPassword:
          emailForResetPassword ?? this.emailForResetPassword,
      isResetEmailSent: isResetEmailSent ?? this.isResetEmailSent,
      resetToken: resetToken ?? this.resetToken,
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
  FieldError? resetPasswordEmail;
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
    this.resetPasswordEmail,
    this.newPassword,
    this.confirmPassword,
  });

  static RegisterFieldErrors noErrors() {
    return RegisterFieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    if (firstName != null) {
      buffer.write('Ім\'я ');
    }
    if (email != null) {
      buffer.write('E-mail ');
    }
    if (mobileNumber != null) {
      buffer.write('Номер телефону ');
    }
    if (password != null) {
      buffer.write('Пароль ');
    }
    if (confirmRegisterPassword != null) {
      buffer.write('Підтвердження пароля ');
    }
    if (confirmationCode != null) {
      buffer.write('Код підтвердження, ');
    }
    if (resetPasswordEmail != null) {
      buffer.write('E-mail для скидування паролю, ');
    }
    if (newPassword != null) {
      buffer.write('Новий пароль');
    }
    if (confirmPassword != null) {
      buffer.write('Підтвердження нового паролю');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
