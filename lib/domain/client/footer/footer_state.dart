import 'package:moxy/domain/copyable.dart';

import '../../validation_mixin.dart';

class FooterState implements Copyable<FooterState> {
  final String userEmail;
  final String errorMessage;

  // field errors
  FieldErrors errors;

  FooterState({
    required this.userEmail,
    required this.errorMessage,
    required this.errors,
  });

  static defaultFooterState() {
    return FooterState(
      userEmail: '',
      errorMessage: '',
      errors: FieldErrors(),
    );
  }

  @override
  FooterState copyWith({
    String? userEmail,
    String? errorMessage,
    FieldErrors? errors,
  }) {
    return FooterState(
      userEmail: userEmail ?? this.userEmail,
      errorMessage: errorMessage ?? this.errorMessage,
      errors: errors ?? this.errors,
    );
  }
}

class FieldErrors {
  FieldError? emailUser;

  FieldErrors({
    this.emailUser,
  });

  static FieldErrors noErrors() {
    return FieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (emailUser != null) {
      buffer.write('emailUser ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
