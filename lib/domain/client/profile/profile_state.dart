import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/validation_mixin.dart';

import '../../models/profile.dart';

class ProfileState implements Copyable<ProfileState> {
  final bool isLoading;
  final int activePage;
  final Profile profile;
  final List<Order> historyOrders;
  final ProfilePassword password;
  final bool showSaveButton;

  // Field errors
  final ProfileFieldErrors errors;

  ProfileState({
    required this.isLoading,
    required this.activePage,
    required this.profile,
    required this.historyOrders,
    required this.password,
    required this.errors,
    required this.showSaveButton,
  });

  static defaultState() {
    return ProfileState(
        isLoading: false,
        showSaveButton: true,
        activePage: 0,
        profile: Profile.defaultProfile(),
        historyOrders: [],
        password: ProfilePassword.defaultProfilePassword(),
        errors: ProfileFieldErrors.noErrors());
  }

  @override
  ProfileState copyWith({
    bool? isLoading,
    int? activePage,
    Profile? profile,
    List<Order>? historyOrders,
    ProfilePassword? password,
    ProfileFieldErrors? errors,
    bool? showSaveButton,
  }) {
    return ProfileState(
        isLoading: isLoading ?? this.isLoading,
        activePage: activePage ?? this.activePage,
        profile: profile ?? this.profile,
        historyOrders: historyOrders ?? this.historyOrders,
        password: password ?? this.password,
        errors: errors ?? this.errors,
        showSaveButton: showSaveButton ?? this.showSaveButton);
  }
}

class ProfileFieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? phoneNumber;
  FieldError? oldPassword;
  FieldError? newPassword;
  FieldError? reapeatNewPassword;

  ProfileFieldErrors({
    this.firstName,
    this.secondName,
    this.phoneNumber,
    this.oldPassword,
    this.newPassword,
    this.reapeatNewPassword,
  });

  static ProfileFieldErrors noErrors() {
    return ProfileFieldErrors();
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
