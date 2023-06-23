import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/domain/all_users/all_users_effects.dart';
import 'package:moxy/domain/all_users/all_users_state.dart';
import 'package:moxy/services/cubit_with_effects.dart';
import 'package:moxy/utils/common.dart';

import '../../services/get_it.dart';
import '../mappers/user_mapper.dart';
import '../ui_effect.dart';

class AllUsersCubit extends CubitWithEffects<AllUsersState, UiEffect> {
  final userMapper = locate<UserMapper>();
  final userRepository = locate<AuthRepository>();

  AllUsersCubit() : super(AllUsersState.defaultAllUsersState()) {
    allUsers();
  }

  void allUsers() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await userRepository.getAllUsers();
      result.when((users) {
        emit(state.copyWith(allUsers: users));
        emit(state.copyWith(isLoading: false));
      }, (error) {
        emitEffect(UsersLoadingFailed(error.toString()));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }
}
