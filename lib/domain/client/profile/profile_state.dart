import 'package:moxy/domain/copyable.dart';

class ProfileState implements Copyable<ProfileState> {
  final bool isLoading;

  ProfileState({
    required this.isLoading,
  });

  static defaultState() {
    return ProfileState(
      isLoading: false,
    );
  }

  @override
  ProfileState copyWith({
    bool? isLoading,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
