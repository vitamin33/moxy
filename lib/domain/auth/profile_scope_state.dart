import 'package:moxy/domain/models/profile.dart';

class ProfileScopeState {
  final Profile? profile;
  final bool isLoading;
  final String? error;

  ProfileScopeState({this.profile, this.isLoading = false, this.error});

  factory ProfileScopeState.initial() => ProfileScopeState();

  factory ProfileScopeState.loading() => ProfileScopeState(isLoading: true);

  factory ProfileScopeState.loaded(Profile? profile) =>
      ProfileScopeState(profile: profile);

  factory ProfileScopeState.error(String error) =>
      ProfileScopeState(error: error);
}
