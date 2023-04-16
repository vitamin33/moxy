// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';

import '../models/result.dart';
import '../models/user.dart' as u;
import '../../services/authentication_service.dart';
import '../../utils/common.dart';

class UserRepository {
  final _authService = AuthenicationService.instance;

  ValueNotifier<u.User?> currentUserNotifier = ValueNotifier<u.User?>(null);

  StreamSubscription? _authStreamSubscription;

  String? get currentUserUID => _authService.auth.currentUser?.uid;

  set setCurrentUser(u.User? user) {
    currentUserNotifier.value = user;
    currentUserNotifier.notifyListeners();
  }

  UserRepository() {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authStreamSubscription?.cancel();
    _authStreamSubscription = null;

    _authStreamSubscription = _authService.authStates().listen((firebaseUser) {
      if (firebaseUser != null) {
        final String uid = firebaseUser.uid;
        getCurrentUser(uid);
        moxyPrint("CURRENT USER -> $uid");
      } else {
        moxyPrint("NO CURRENT USER");
      }
    });
  }

  Future<Either<ErrorHandler, u.User>> getCurrentUser(String uid) async {
    try {
      //TODO implement real user storing
      final userExist = true;
      if (userExist) {
        final u.User user = u.User(
            uid: "4234324",
            email: "crazy@gmail.com",
            name: "Alice",
            phone: "0909343",
            profileImageUrl: "",
            createdAt: 12312313,
            updatedAt: 32123213,
            isActive: true,
            dob: 12321,
            permisions: List.empty(),
            favorites: List.empty());

        setCurrentUser = user;

        return Right(user);
      } else {
        return const Left(ErrorHandler(message: "User does not exist"));
      }
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<Either<ErrorHandler, u.User>> login(
      String email, String password) async {
    try {
      final logIn = await _authService.logIn(email, password);
      if (logIn.isRight) {
        final firebaseUser = logIn.right;
        final getUser = await getCurrentUser(firebaseUser.uid);
        if (getUser.isRight) {
          return Right(getUser.right);
        }

        return Left(getUser.left);
      } else {
        return Left(ErrorHandler(message: logIn.left.message.toString()));
      }
    } catch (e) {
      return Left(ErrorHandler(message: e.toString()));
    }
  }

  Future<void> logout() async {
    setCurrentUser = null;
    await _authService.logout();
  }
}
