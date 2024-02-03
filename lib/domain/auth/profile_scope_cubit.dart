import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/profile_scope_state.dart';
import 'package:moxy/services/get_it.dart';
import '../../../data/repositories/profile_repository.dart';

class ProfileScopeCubit extends Cubit<ProfileScopeState> {
  final ProfileRepository profileRepository = locate<ProfileRepository>();

  ProfileScopeCubit() : super(ProfileScopeState.initial());

  void getProfile() async {
    try {
      emit(ProfileScopeState.loading());
      final profile = await profileRepository.getProfile();
      final result = profile.tryGetSuccess();
      emit(ProfileScopeState.loaded(result));
    } catch (e) {
      emit(ProfileScopeState.error(e.toString()));
    }
  }
}
