// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/data/secure_storage.dart';
import '../../services/get_it.dart';
import '../roles.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final storage = locate<ISecureStorageRepository>();
  final authRepository = locate<AuthRepository>();

  late TextEditingController phoneController;
  late TextEditingController passwordController;
  String walletConnectURI = '';
  final PageController pageController = PageController(initialPage: 0);

  LoginCubit()
      : super(LoginState(
            mobileNumber: '',
            password: '',
            activePage: 0,
            state:const AuthState())) {
    _checkLoggedInState();
    emit(state.copyWith(mobileNumber: '', password: ''));
  }

  void mobileNumberChanged(String value) {
    final email = value;
    emit(state.copyWith(
      mobileNumber: email,
    ));
  }

  void passwordChanged(String value) {
    final password = value;
    emit(state.copyWith(
      password: password,
    ));
  }

  void onChangePage(int page) {
    emit(state.copyWith(activePage: page));
  }

  void logInWithCredentials() async {
    try {
      emit(state.copyWith(state: Loading()));

      final result = await authRepository.loginWithCredentials(
          state.mobileNumber, state.password);

      result.when((role) {
        emit(state.copyWith(state: LoginWithCredsSuccess(role: role)));
      }, (error) {
        emit(state.copyWith(
            state:
                LoginFailed(message: 'Unable to login. Try one more time.')));
      });
    } on Exception catch (error) {
      emit(state.copyWith(state: LoginFailed(message: error.toString())));
    }
  }

  void signOut() async {
    try {
      emit(state.copyWith(state: Loading()));
      await authRepository.logout();
      await storage.clear();
      emit(state.copyWith(state: Logout()));
    } catch (error) {
      emit(state.copyWith(state: LogoutFailed()));
    }
  }

  void clearState() {
    emit(state.copyWith(state: const AuthState()));
  }

  _checkLoggedInState() async {
    bool isLoggedIn = await authRepository.checkLoggedInState();
    Role? userRole = await authRepository.getUserRole();
    if (isLoggedIn && userRole != null) {
      emit(state.copyWith(state: LoginWithCredsSuccess(role: userRole)));
    }
  }

  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void perviousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void moveToPage(int page) {
    emit(state.copyWith(activePage: page));
    pageController.animateToPage(page,
        duration: const Duration(microseconds: 300), curve: Curves.linear);
  }
}
