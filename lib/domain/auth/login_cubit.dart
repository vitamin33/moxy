// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/data/secure_storage.dart';
import '../../data/repositories/user_repository.dart';
import '../../services/get_it.dart';
import '../../services/navigation_service.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final storage = locate<ISecureStorageRepository>();
  final userRepository = locate<UserRepository>();
  final authRepository = locate<AuthRepository>();
  final navigationService = locate<NavigationService>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  String walletConnectURI = '';

  LoginCubit() : super(const LoginState.initial()) {
    _checkLoggedInState();
  }

  void emailChanged(String value) {
    final email = value;
    emit(state.copyWith(
      email: email,
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
          state.email, state.password);

      if (result) {
        emit(state.copyWith(state: LoginWithCredsSuccess()));
      } else {
        emit(state.copyWith(
            state:
                LoginFailed(message: 'Unable to login. Try one more time.')));
      }
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
    if (isLoggedIn) {
      emit(state.copyWith(state: LoginWithCredsSuccess()));
    }
  }
}
