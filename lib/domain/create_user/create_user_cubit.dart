import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/domain/create_user/create_user_effects.dart';
import 'package:moxy/domain/mappers/user_mapper.dart';
import 'package:moxy/domain/models/user.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/navigation_service.dart';
import 'package:moxy/utils/common.dart';
import 'package:bloc_effects/bloc_effects.dart';

import '../../constant/route_name.dart';
import '../../services/get_it.dart';
import 'create_user_state.dart';

class CreateUserCubit extends CubitWithEffects<CreateUserState, UiEffect>
    with ValidationMixin {
  final userMapper = locate<UserMapper>();
  final userRepository = locate<AuthRepository>();
  final navigationService = locate<NavigationService>();

  CreateUserCubit()
      : super(
          CreateUserState(
            editedUser: User.defaultUser(),
            isLoading: false,
            isSuccess: false,
            errorMessage: '',
            errors: UserFieldErrors.noErrors(),
          ),
        );

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();

  void createGuestUser() async {
    try {
      if (validateFields()) {
        emit(state.copyWith(isLoading: true));
        final user = userMapper.mapToNetworkUser(state.editedUser);
        final createdUser = await userRepository.createGuestUser(user);
        createdUser.when((success) {
          emit(state.copyWith(isLoading: false));
          emitEffect(const UserCreatedSuccess());
        }, (error) {
          emit(
              state.copyWith(errorMessage: error.toString(), isLoading: false));
        });
      }
    } catch (e) {
      moxyPrint(e);
    }
  }

  // Thisss function!!!
  void backToProduct() {
    clearState();
    navigationService.navigatePushReplaceName(productsPath); //doesnt work
  }

  void firstNameChanged(value) {
    final String name = value;
    emit(
        state.copyWith(editedUser: state.editedUser.copyWith(firstName: name)));
  }

  void secondNameChanged(value) {
    final String secondName = value;
    emit(state.copyWith(
        editedUser: state.editedUser.copyWith(secondName: secondName)));
  }

  void mobileNumberChanged(value) {
    final String number = value;
    emit(state.copyWith(
        editedUser: state.editedUser.copyWith(mobileNumber: number)));
  }

  void cityChanged(value) {
    final String city = value;
    emit(state.copyWith(editedUser: state.editedUser.copyWith(city: city)));
  }

  void instagramChanged(value) {
    final String instagram = value;
    emit(state.copyWith(
        editedUser: state.editedUser.copyWith(instagram: instagram)));
  }

  void clearState() {
    emit(CreateUserState.defaultCreateUserState());
  }

  void clearErrorState() {
    emit(state.copyWith(errorMessage: ''));
  }

  bool validateFields() {
    final errors = UserFieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.editedUser.firstName)) {
      errors.firstName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.editedUser.secondName)) {
      errors.secondName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.editedUser.mobileNumber)) {
      errors.phoneNumber = FieldError.empty;
      noErrors = false;
    }
    if (!phoneNumberRegExp.hasMatch(state.editedUser.mobileNumber)) {
      errors.phoneNumber = FieldError.invalid;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(UserValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(errors: errors));
    return noErrors;
  }

  void tryToParseDataFromClipboard() async {
    try {
      ClipboardData? data = await Clipboard.getData('text/plain');
      final text = data?.text ?? '';
      final numLines = '\n'.allMatches(text).length + 1;
      String firstName = '';
      String secondName = '';
      String phoneNumber = '';
      String city = '';

      if (numLines > 1) {
        final lines = text.split('\n');
        final first = lines[0];
        final names = nameSurnameRegExp.firstMatch(first);
        if (names != null) {
          List<String>? fullName = names[0]?.split(' ');
          secondName = fullName?[0] ?? '';
          firstName = fullName?[1] ?? '';
        }
        if (firstName.isEmpty && secondName.isEmpty) {
          final first = lines[0];
          final names = nameSurnameRegExp.firstMatch(first);
          if (names != null) {
            List<String>? fullName = names[0]?.split(' ');
            firstName = fullName?[0] ?? '';
            secondName = fullName?[1] ?? '';
          }
        }
      } else {
        final names = nameSurnameRegExp.firstMatch(text);
        if (names != null) {
          List<String>? fullName = names[0]?.split(' ');
          firstName = fullName?[0] ?? '';
          secondName = fullName?[1] ?? '';
        }
      }
      final phones = phoneNumberRegExp.firstMatch(text);
      if (phones != null) {
        phoneNumber = phones[0] ?? '';
        phoneNumber = phoneNumber.replaceAll(RegExp('[^0-9]'), '');
      }
      emit(
        state.copyWith(
          editedUser: state.editedUser.copyWith(
            firstName: firstName,
            secondName: secondName,
            mobileNumber: phoneNumber,
            city: city,
          ),
        ),
      );
      firstNameController.text = firstName;
      secondNameController.text = secondName;
      mobileNumberController.text = phoneNumber;
    } catch (e) {
      emitEffect(const DataParseFailed());
    }
  }
}
