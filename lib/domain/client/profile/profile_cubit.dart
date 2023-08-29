// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:moxy/services/get_it.dart';
import '../../../data/repositories/profile_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.defaultState()) {
    getProfile();
  }
  final profileRepository = locate<ProfileRepository>();

  final PageController pageController = PageController(initialPage: 0);

  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }

  void getProfile() {
    // emit(state.copyWith(activePage: page));
  }
}
