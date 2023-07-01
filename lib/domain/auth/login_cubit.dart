// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/data/secure_storage.dart';
import '../../services/get_it.dart';
import '../../services/navigation_service.dart';
import '../roles.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final storage = locate<ISecureStorageRepository>();
  final authRepository = locate<AuthRepository>();
  final navigationService = locate<NavigationService>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  String walletConnectURI = '';

  LoginCubit()
      : super(LoginState(mobileNumber: '', password: '', state: AuthState())) {
    //_checkLoggedInState();
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
}
