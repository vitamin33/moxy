// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.defaultState()) {
  }

  final PageController pageController = PageController(initialPage: 0);


  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }
}
