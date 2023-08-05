import 'package:moxy/domain/copyable.dart';

class BasketState implements Copyable<BasketState> {
  final bool isLoading;

  BasketState({
    required this.isLoading,
  });

  static defaultState() {
    return BasketState(
      isLoading: false,
    );
  }

  @override
  BasketState copyWith({
    bool? isLoading,
  }) {
    return BasketState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
