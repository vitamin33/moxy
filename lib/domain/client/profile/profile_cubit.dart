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
import 'package:moxy/services/navigation/web/client_home_router_cubit.dart';
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
    firstnameController = TextEditingController(text: state.profile.firstName);
    secondnameController =
        TextEditingController(text: state.profile.secondName);
    mobileNumberController =
        TextEditingController(text: state.profile.mobileNumber);
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
            city: state.profile.city
                .copyWith(presentName: state.profile.city.presentName),
            instagram: ''),
        state.profile.city,
        state.profile.warehouse,
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

  bool validateFields() {
    final errors = ProfileFieldErrors.noErrors();
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
        case ClientHomeRoute.ordersPath:
          return 1;
        case ClientHomeRoute.addressesPath:
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
        return ClientHomeRoute.ordersPath;
      case 2:
        return ClientHomeRoute.addressesPath;
      default:
        return null;
    }
  }
}
