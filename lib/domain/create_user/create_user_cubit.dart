import 'package:flutter/material.dart';
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

  final TextEditingController firstName = TextEditingController();
  final TextEditingController secondName = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController instagram = TextEditingController();

  void createGuestUser() async {
    try {
      emit(state.copyWith(isLoading: true));
      final user = userMapper.mapToNetworkUser(state.editedUser);
      final createdUser = await userRepository.createGuestUser(user);
      createdUser.when((success) {
        emit(state.copyWith(isLoading: false));
        emit(state.copyWith(isSuccess: true));
      }, (error) {
        emit(state.copyWith(errorMessage: error.toString(), isLoading: false));
      });
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
    // if (!isFieldEmpty(state.editedUser.city)) {
    //   errors.city = FieldError.invalid;
    //   noErrors = false;
    // }
    // if (!isFieldEmpty(state.editedUser.instagram)) {
    //   errors.instagramLink = FieldError.invalid;
    //   noErrors = false;
    // }
    if (!noErrors) {
      emitEffect(ValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(errors: errors));
    return noErrors;
  }
}
