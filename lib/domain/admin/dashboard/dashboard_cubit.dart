// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import '../../../services/get_it.dart';
import '../../../services/navigation_service.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final authRepository = locate<AuthRepository>();
  final navigationService = locate<NavigationService>();

  late TextEditingController emailController;
  late TextEditingController passwordController;
  String walletConnectURI = '';

  DashboardCubit() : super(DashboardState());
}
