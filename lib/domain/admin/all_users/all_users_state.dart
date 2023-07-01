import 'package:moxy/domain/models/user.dart';

import '../../copyable.dart';

class AllUsersState implements Copyable<AllUsersState> {
  final List<User> allUsers;
  final bool isLoading;
  final String? errorMessage;

  AllUsersState({
    required this.allUsers,
    required this.isLoading,
    this.errorMessage,
  });

  static AllUsersState defaultAllUsersState() {
    return AllUsersState(
      allUsers: [],
      isLoading: false,
      errorMessage: '',
    );
  }

  @override
  AllUsersState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<User>? allUsers,
  }) {
    return AllUsersState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        allUsers: allUsers ?? this.allUsers);
  }
}
