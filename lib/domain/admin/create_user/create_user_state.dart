import 'package:moxy/domain/validation_mixin.dart';

import '../../copyable.dart';
import '../../models/user.dart';

class CreateUserState implements Copyable<CreateUserState> {
  bool isLoading;
  bool isSuccess;
  String errorMessage;

  User editedUser;

  // field errors
  UserFieldErrors errors;

  CreateUserState({
    required this.editedUser,
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
    required this.errors,
  });

  static CreateUserState defaultCreateUserState() {
    return CreateUserState(
      editedUser: User.defaultUser(),
      isLoading: false,
      isSuccess: false,
      errorMessage: '',
      errors: UserFieldErrors(),
    );
  }

  @override
  CreateUserState copyWith({
    User? editedUser,
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    UserFieldErrors? errors,
  }) {
    return CreateUserState(
      editedUser: editedUser ?? this.editedUser,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      errors: errors ?? this.errors,
    );
  }
}

class UserFieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? phoneNumber;
  FieldError? city;
  FieldError? instagramLink;
  UserFieldErrors({
    this.firstName,
    this.secondName,
    this.phoneNumber,
    this.city,
    this.instagramLink,
  });

  static UserFieldErrors noErrors() {
    return UserFieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (firstName != null) {
      buffer.write('firstName ');
    }
    if (secondName != null) {
      buffer.write('secondName ');
    }
    if (phoneNumber != null) {
      buffer.write('phoneNumber ');
    }
    if (city != null) {
      buffer.write('city ');
    }
    if (instagramLink != null) {
      buffer.write('instagramLink ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
