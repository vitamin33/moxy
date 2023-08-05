import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'web_home_router_state.dart';

class ClientHomeRouterCubit extends Cubit<ClientHomeRouterState> {
  ClientHomeRouterCubit() : super(const HomeRouteState());
  void goToFavourites([String? text]) => emit(FavouritesRouteState(text));
  void goToHome([String? text]) => emit(HomeRouteState(text));
  void goToBasket([String? text]) => emit(BasketRouteState(text));
  void goToProfile([String? text]) => emit(ProfileRouteState(text));

  void popExtra() {
    if (state is HomeRouteState) {
      goToHome();
    } else {
      goToFavourites();
    }
  }

  void navigateTo(ClientHomeRouterState initialRoute) {
    switch (initialRoute.runtimeType) {
      case HomeRouteState:
        goToHome();
        break;
      case FavouritesRouteState:
        goToFavourites();
        break;
      case BasketRouteState:
        goToBasket();
        break;
      case ProfileRouteState:
        goToProfile();
        break;
    }
  }

  void favouritesPressed() {
    if (state is! FavouritesRouteState) {
      goToFavourites();
    }
  }

  void profilePressed() {
    if (state is! ProfileRouteState) {
      goToProfile();
    }
  }

  void basketPressed() {
    if (state is! BasketRouteState) {
      goToBasket();
    }
  }

  void searchPressed() {
    // TODO impl search state
  }

  void tabControlPressed() {
    if (state is! HomeRouteState) {
      goToHome();
    }
  }
}
