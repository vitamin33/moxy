// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import '../../services/get_it.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthorizedState> {
  final authRepository = locate<AuthRepository>();

  AuthCubit() : super(AuthorizedState(isAuthorized: false)) {
    _checkLoggedInState();
  }

  _checkLoggedInState() async {
    bool isLoggedIn = await authRepository.checkLoggedInState();
    emit(AuthorizedState(isAuthorized: isLoggedIn));
  }
}
