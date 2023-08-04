import 'package:moxy/domain/copyable.dart';

class FavouritesState implements Copyable<FavouritesState> {
  final bool isLoading;

  FavouritesState({
    required this.isLoading,
  });

  static defaultState() {
    return FavouritesState(
      isLoading: false,
    );
  }

  @override
  FavouritesState copyWith({
    bool? isLoading,
  }) {
    return FavouritesState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
