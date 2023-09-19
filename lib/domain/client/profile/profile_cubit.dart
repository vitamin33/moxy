// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/domain/client/profile/profile_effects.dart';
import 'package:moxy/domain/mappers/user_mapper.dart';
import 'package:moxy/domain/models/profile.dart';
import 'package:moxy/domain/models/user.dart';
import 'package:moxy/domain/ui_effect.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/services/get_it.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../utils/common.dart';
import '../../mappers/profile_mapper.dart';
import '../../models/city.dart';
import '../../models/warehouse.dart';
import 'profile_state.dart';

class ProfileCubit extends CubitWithEffects<ProfileState, UiEffect>
    with ValidationMixin {
  late TextEditingController firstnameController;
  late TextEditingController secondnameController;
  late TextEditingController mobileNumberController;

  ProfileCubit() : super(ProfileState.defaultState()) {
    getProfile();
    firstnameController = TextEditingController(text: state.profile.firstName);
    secondnameController =
        TextEditingController(text: state.profile.secondName);
    mobileNumberController =
        TextEditingController(text: state.profile.mobileNumber);
  }
  final profileRepository = locate<ProfileRepository>();
  final authRepository = locate<AuthRepository>();
  final profileMapper = locate<ProfileMapper>();
  final userMapper = locate<UserMapper>();

  final PageController pageController = PageController(initialPage: 0);
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatNewPasswordController =
      TextEditingController();

  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }

  void getProfile() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await profileRepository.getProfile();
      result.when((success) {
        final profile = profileMapper.mapToProfile(success);
        firstnameController.text = profile.firstName;
        secondnameController.text = profile.secondName;
        mobileNumberController.text = profile.mobileNumber;
        emit(state.copyWith(profile: profile, isLoading: false));
      }, (error) {
        emit(state.copyWith(
            errorMessage: 'Failed getProfile: ${error.toString()}'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void clearErrorState() {
    emit(state.copyWith(errorMessage: ''));
  }

  void clearSuccesState() {
    emit(state.copyWith(successMessage: ''));
  }

  void passwordEqualError() {
    emit(state.copyWith(errorMessage: 'password not Equal'));
  }

  void firstNameChanged(value) {
    final String firstName = value;
    emit(state.copyWith(profile: state.profile.copyWith(firstName: firstName)));
  }

  void secondNameChanged(value) {
    final String secondName = value;
    emit(state.copyWith(
        profile: state.profile.copyWith(secondName: secondName)));
  }

  void phoneNumberChanged(String value) {
    if (value.isEmpty) {
      return;
    }
    final String mobileNumber = value;
    emit(state.copyWith(
        profile: state.profile.copyWith(mobileNumber: mobileNumber)));
  }

  void oldPasswordChanged(value) {
    final String oldPassword = value;
    emit(state.copyWith(
        password: state.password.copyWith(oldPassword: oldPassword)));
  }

  void newPasswordChanged(value) {
    final String newPassword = value;
    emit(state.copyWith(
        password: state.password.copyWith(newPassword: newPassword)));
  }

  void repeatNewPasswordChanged(value) {
    final String repeatNewPassword = value;
    emit(state.copyWith(
        password:
            state.password.copyWith(repeatNewPassword: repeatNewPassword)));
  }

  void selectCity(City? city) {
    emit(state.copyWith(
        profile: state.profile
            .copyWith(city: city, warehouse: Warehouse.defaultWarehouse())));
  }

  void selectWarehouse(Warehouse? warehouse) {
    emit(state.copyWith(profile: state.profile.copyWith(warehouse: warehouse)));
  }

  void editProfile() async {
    try {
      final networkUser = userMapper.mapToNetworkProfileUser(
        User(
            id: state.profile.id,
            firstName: state.profile.firstName,
            secondName: state.profile.secondName,
            mobileNumber: state.profile.mobileNumber,
            city: state.profile.city.presentName,
            instagram: ''),
        state.profile.city,
        state.profile.warehouse,
      );

      final result = await authRepository.editUser(networkUser);
      result.when((success) {
        emit(state.copyWith(successMessage: 'Success edit profile'));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed edit profile'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void editPassword() async {
    if (newPasswordController.text == repeatNewPasswordController.text &&
        oldPasswordController.text.isNotEmpty) {
      try {
        final result = await authRepository.editUserPassword(state.password);
        result.when((success) {
          newPasswordController.text = '';
          oldPasswordController.text = '';
          repeatNewPasswordController.text = '';
          emit(state.copyWith(
              successMessage: 'Success edit profile password',
              password: ProfilePassword.defaultProfilePassword()));
        }, (error) {
          emit(state.copyWith(errorMessage: 'Failed edit profile password'));
        });
      } catch (e) {
        moxyPrint('$e');
      }
    }
  }

  bool validateFields() {
    final errors = FieldErrors.noErrors();
    var noErrors = true;
    if (isFieldEmpty(state.profile.firstName)) {
      errors.firstName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.profile.secondName)) {
      errors.secondName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(state.profile.mobileNumber)) {
      errors.phoneNumber = FieldError.empty;
      noErrors = false;
    }
    if (validateRepeatPassword(
        state.password.newPassword, state.password.repeatNewPassword)) {
      errors.reapeatNewPassword = FieldError.empty;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(ValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(errors: errors));
    return noErrors;
  }
}
