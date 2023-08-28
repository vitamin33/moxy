import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'client_home_router_state.dart';

class ClientHomeRouterCubit extends Cubit<ClientHomeRoute> {
  ClientHomeRouterCubit() : super(const HomeRoute());
  void goToFavourites([String? text]) => emit(FavouritesRoute(text));
  void goToHome([int? tabIndex = 0]) => emit(HomeRoute(tabIndex));
  void goToCheckout([String? text]) => emit(CheckoutRoute(text));
  void goToProfile([String? text]) => emit(ProfileRoute(text));

  void popExtra() {
    if (state is HomeRoute) {
      goToHome();
    } else {
      goToFavourites();
    }
  }

  void navigateTo(ClientHomeRoute initialRoute) {
    switch (initialRoute.runtimeType) {
      case HomeRoute:
        goToHome();
        break;
      case FavouritesRoute:
        goToFavourites();
        break;
      case CheckoutRoute:
        goToCheckout();
        break;
      case ProfileRoute:
        goToProfile();
        break;
    }
  }

  void favouritesPressed() {
    if (state is! FavouritesRoute) {
      goToFavourites();
    }
  }

  void profilePressed() {
    if (state is! ProfileRoute) {
      goToProfile();
    }
  }

  void basketPressed() {
    if (state is! CheckoutRoute) {
      goToCheckout();
    }
  }

  void searchPressed() {
    // TODO impl search state
  }

  void tabControlTouched({
    required int controllerIndex,
    required int newIndex,
  }) {
    if (state is! HomeRoute && controllerIndex == newIndex) {
      goToHome(newIndex);
    }
  }

  void tabControlSelected(int? index) {
    if (state is! HomeRoute) {
      goToHome(index);
    } else {
      index ??= (state as HomeRoute).tabIndex;
      goToHome(index);
    }
  }
}
