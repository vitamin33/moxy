import 'package:moxy/domain/copyable.dart';

class ProfileState implements Copyable<ProfileState> {
  final bool isLoading;
  final int activePage;

  ProfileState({
    required this.isLoading,
    required this.activePage,
  });

  static defaultState() {
    return ProfileState(
      isLoading: false,
      activePage: 0,
    );
  }

  @override
  ProfileState copyWith({
    bool? isLoading,
  int? activePage, 

  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      activePage: activePage ?? this.activePage,
    );
  }
}
