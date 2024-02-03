// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:moxy/config/routes.dart';
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
  late PageController pageController;
  final String? extraPagePath;

  ProfileCubit({required this.extraPagePath})
      : super(ProfileState.defaultState()) {
    getProfile();
    getProfileOrders();
    firstnameController = TextEditingController(text: state.profile?.firstName);
    secondnameController =
        TextEditingController(text: state.profile?.secondName);
    mobileNumberController =
        TextEditingController(text: state.profile?.mobileNumber);
    int activePage = _calculateInitialPage(extraPagePath);
    pageController = PageController(initialPage: activePage);
    emit(state.copyWith(
        activePage: activePage, showSaveButton: _showSaveButton(activePage)));
  }
  final profileRepository = locate<ProfileRepository>();
  final authRepository = locate<AuthRepository>();
  final profileMapper = locate<ProfileMapper>();
  final userMapper = locate<UserMapper>();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatNewPasswordController =
      TextEditingController();

  void onChangePage(int page) {
    emit(state.copyWith(
        activePage: page, showSaveButton: _showSaveButton(page)));
    final addPath = _generateAdditionalPagePath(page);
    emitEffect(ProfileActivePageChanged(addPath));
  }

  void getProfile() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await profileRepository.getProfile();
      result.when((success) {
        firstnameController.text = success.firstName;
        secondnameController.text = success.secondName;
        mobileNumberController.text = success.mobileNumber;
        emit(state.copyWith(profile: success, isLoading: false));
      }, (error) {
        emitEffect(
            ProfileApiRequestFailed('Failed get profile ${error.toString()}'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void getProfileOrders() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await profileRepository.getProfileOrders();
      result.when((success) {
        emit(state.copyWith(historyOrders: success, isLoading: false));
      }, (error) {
        emitEffect(ProfileApiRequestFailed(
            'Failed  get profile orders ${error.toString()}'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void firstNameChanged(value) {
    final String firstName = value;
    final profile = currentProfile();
    emit(state.copyWith(profile: profile.copyWith(firstName: firstName)));
  }

  void secondNameChanged(value) {
    final String secondName = value;
    final profile = currentProfile();
    emit(state.copyWith(profile: profile.copyWith(secondName: secondName)));
  }

  void phoneNumberChanged(String value) {
    if (value.isEmpty) {
      return;
    }
    final String mobileNumber = value;
    final profile = currentProfile();
    emit(state.copyWith(profile: profile.copyWith(mobileNumber: mobileNumber)));
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
    final profile = currentProfile();
    emit(state.copyWith(
        profile: profile.copyWith(
            city: city, warehouse: Warehouse.defaultWarehouse())));
  }

  void selectWarehouse(Warehouse? warehouse) {
    final profile = currentProfile();
    emit(state.copyWith(profile: profile.copyWith(warehouse: warehouse)));
  }

  Profile currentProfile() {
    return state.profile ?? Profile.defaultProfile();
  }

  void editProfile() async {
    try {
      final profile = currentProfile();
      final networkUser = userMapper.mapToNetworkProfileUser(
        User(
            id: profile.id,
            firstName: profile.firstName,
            secondName: profile.secondName,
            mobileNumber: profile.mobileNumber,
            city: profile.city.copyWith(presentName: profile.city.presentName),
            instagram: ''),
        profile.city,
        profile.warehouse,
      );

      final result = await authRepository.editUser(networkUser);
      result.when((success) {
        emitEffect(ProfileSuccess('Success edit profile'));
      }, (error) {
        emitEffect(ProfileApiRequestFailed('Failed edit profile'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void editPassword() async {
    if (oldPasswordController.text.isNotEmpty) {
      try {
        final result = await authRepository.editUserPassword(state.password);
        result.when((success) {
          newPasswordController.text = '';
          oldPasswordController.text = '';
          repeatNewPasswordController.text = '';
          emitEffect(ProfileSuccess('Success edit profile password'));
          emit(state.copyWith(
              password: ProfilePassword.defaultProfilePassword()));
        }, (error) {
          emitEffect(ProfileApiRequestFailed('Failed edit profile password'));
        });
      } catch (e) {
        moxyPrint('$e');
      }
    }
  }

  void signOut() async {
    emit(state.copyWith(isLoading: true));
    await authRepository.logout();
    emit(state.copyWith(isLoading: false));
  }

  bool validateFields() {
    final errors = ProfileFieldErrors.noErrors();
    var noErrors = true;
    final profile = currentProfile();

    if (isFieldEmpty(profile.firstName)) {
      errors.firstName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(profile.secondName)) {
      errors.secondName = FieldError.empty;
      noErrors = false;
    }
    if (isFieldEmpty(profile.mobileNumber)) {
      errors.phoneNumber = FieldError.empty;
      noErrors = false;
    }
    if (validateRepeatPassword(
        state.password.newPassword, state.password.repeatNewPassword)) {
      errors.reapeatNewPassword = FieldError.empty;
      noErrors = false;
    }
    if (!noErrors) {
      emitEffect(ProfileValidationFailed(errors.formErrorMessageFields()));
    }
    emit(state.copyWith(errors: errors));
    return noErrors;
  }

  bool _showSaveButton(int activePage) {
    return activePage != 1; // not equal index of orders history
  }

  int _calculateInitialPage(String? extraPagePath) {
    if (extraPagePath != null) {
      switch (extraPagePath) {
        case Routes.profileOrders:
          return 1;
        case Routes.profileAddresses:
          return 2;
        default:
          return 0;
      }
    }
    return 0;
  }

  String? _generateAdditionalPagePath(int activePage) {
    switch (activePage) {
      case 1:
        return Routes.profileOrders;
      case 2:
        return Routes.profileAddresses;
      default:
        return Routes.profileInfo;
    }
  }
}
