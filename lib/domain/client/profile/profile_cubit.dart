// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:moxy/services/get_it.dart';
import '../../../data/repositories/profile_repository.dart';
import '../../../utils/common.dart';
import '../../mappers/profile_mapper.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
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
  final profileMapper = locate<ProfileMapper>();

  final PageController pageController = PageController(initialPage: 0);

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
        emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  void clearErrorState() {
    emit(state.copyWith(errorMessage: ''));
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
}
