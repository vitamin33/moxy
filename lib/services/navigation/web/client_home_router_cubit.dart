import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/ui/components/sidesheet.dart';
import 'package:moxy/ui/screens/client/web/basket/basket_page.dart';

part 'client_home_router_state.dart';

class ClientHomeRouterCubit extends Cubit<ClientHomeRoute> {
  ClientHomeRouterCubit() : super(const HomeRoute());
  void goToFavourites([String? text]) => emit(FavouritesRoute(text));
  void goToHome([int? tabIndex = 0]) => emit(HomeRoute(tabIndex));
  void goToCheckout([String? text]) => emit(CheckoutRoute(text));
  void goToProfile([String? text]) => emit(ProfileRoute(text));
  void goToProductDetails([String? text]) => emit(ProductDetailsRoute(text));

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
      case ProductDetailsRoute:
        goToProductDetails();
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

  void basketPressed(context) {
    SideSheet.right(body: const BasketPage(), context: context);
  }

  void searchPressed(context) {
    // TODO impl search state
    goToProductDetails();
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
