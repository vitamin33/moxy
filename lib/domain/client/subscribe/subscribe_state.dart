import 'package:moxy/domain/copyable.dart';

class SubscribeState implements Copyable<SubscribeState> {
  final bool isEmailValid;
  final String firstName;
  final String email;
  final bool isLoading;

  SubscribeState({
    required this.isEmailValid,
    required this.email,
    required this.firstName,
    required this.isLoading,
  });

  static defaultSubscribeState() {
    return SubscribeState(
      isEmailValid: true,
      email: '',
      firstName: '',
      isLoading: false,
    );
  }

  @override
  SubscribeState copyWith({
    bool? isEmailValid,
    String? email,
    String? firstName,
    bool? isLoading,
  }) {
    return SubscribeState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      firstName: firstName ?? this.firstName,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
