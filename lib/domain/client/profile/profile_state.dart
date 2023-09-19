import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/validation_mixin.dart';

import '../../models/profile.dart';

class ProfileState implements Copyable<ProfileState> {
  final bool isLoading;
  final int activePage;
  final Profile profile;
  final List<Order> historyOrders;
  final String errorMessage;
  final String successMessage;
  final ProfilePassword password;

  // Field errors
  final FieldErrors errors;

  ProfileState({
    required this.isLoading,
    required this.activePage,
    required this.profile,
    required this.historyOrders,
    required this.errorMessage,
    required this.successMessage,
    required this.password,
    required this.errors,
  });

  static defaultState() {
    return ProfileState(
        isLoading: false,
        activePage: 0,
        profile: Profile.defaultProfile(),
        historyOrders: [],
        errorMessage: '',
        successMessage: '',
        password: ProfilePassword.defaultProfilePassword(),
        errors: FieldErrors());
  }

  @override
  ProfileState copyWith({
    bool? isLoading,
    int? activePage,
    Profile? profile,
    List<Order>? historyOrders,
    String? errorMessage,
    String? successMessage,
    ProfilePassword? password,
    FieldErrors? errors,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      activePage: activePage ?? this.activePage,
      profile: profile ?? this.profile,
      historyOrders: historyOrders ?? this.historyOrders,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      password: password ?? this.password,
      errors: errors ?? this.errors,
    );
  }
}

class FieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? phoneNumber;
  FieldError? oldPassword;
  FieldError? newPassword;
  FieldError? reapeatNewPassword;

  FieldErrors({
    this.firstName,
    this.secondName,
    this.phoneNumber,
    this.oldPassword,
    this.newPassword,
    this.reapeatNewPassword,
  });

  static FieldErrors noErrors() {
    return FieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (firstName != null) {
      buffer.write('firstName');
    }
    if (secondName != null) {
      buffer.write('secondName');
    }
    if (phoneNumber != null) {
      buffer.write('phoneNumber');
    }
    if (oldPassword != null) {
      buffer.write('oldPassword');
    }
    if (newPassword != null) {
      buffer.write('newPassword');
    }
    if (reapeatNewPassword != null) {
      buffer.write('reapeatNewPassword ');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
