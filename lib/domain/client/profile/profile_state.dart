import 'package:moxy/domain/copyable.dart';

import '../../models/profile.dart';

class ProfileState implements Copyable<ProfileState> {
  final bool isLoading;
  final int activePage;
  final Profile profile;
  final String errorMessage;

  ProfileState({
    required this.isLoading,
    required this.activePage,
    required this.profile,
    required this.errorMessage,
  });

  static defaultState() {
    return ProfileState(
      isLoading: false,
      activePage: 0,
      profile: Profile.defaultProfile(),
      errorMessage: '',
    );
  }

  @override
  ProfileState copyWith({
    bool? isLoading,
    int? activePage,
    Profile? profile,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      activePage: activePage ?? this.activePage,
      profile: profile ?? this.profile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
