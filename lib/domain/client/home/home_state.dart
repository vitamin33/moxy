import 'package:moxy/domain/copyable.dart';

class HomeState implements Copyable<HomeState> {
  final bool isLoading;

  HomeState({
    required this.isLoading,
  });

  static defaultState() {
    return HomeState(
      isLoading: false,
    );
  }

  @override
  HomeState copyWith({
    bool? isLoading,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
