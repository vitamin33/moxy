import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/ui/components/sidesheet.dart';
import 'package:moxy/ui/screens/client/web/basket/basket_page.dart';

part 'client_home_router_state.dart';

class ClientHomeRouterCubit extends Cubit<ClientHomeRoute> {
  final List<ClientHomeRoute> _routeStack = [];

  ClientHomeRouterCubit() : super(const HomeRoute());

  void goToFavourites([String? text, bool addToRouteStack = true]) {
    _pushRoute(FavouritesRoute(text), addToRouteStack: addToRouteStack);
  }

  void goToHome([int? tabIndex = 0, bool addToRouteStack = true]) {
    _pushRoute(HomeRoute(tabIndex), addToRouteStack: addToRouteStack);
  }

  void goToCheckout([String? text, bool addToRouteStack = true]) {
    _pushRoute(CheckoutRoute(text), addToRouteStack: addToRouteStack);
  }

  void goToProfile([String? extraPagePath, bool addToRouteStack = true]) {
    _pushRoute(ProfileRoute(extraPagePath), addToRouteStack: addToRouteStack);
  }

  void goToProfileAddresses([bool addToRouteStack = false]) {
    _pushRoute(const ProfileRoute(ClientHomeRoute.addressesPath),
        addToRouteStack: addToRouteStack);
  }

  void goToProfileOrders([bool addToRouteStack = false]) {
    _pushRoute(const ProfileRoute(ClientHomeRoute.ordersPath),
        addToRouteStack: addToRouteStack);
  }

  void goToProductDetails([String? productId, bool addToRouteStack = true]) {
    _pushRoute(ProductDetailsRoute(productId),
        addToRouteStack: addToRouteStack);
  }

  void goBack() {
    _popRoute();
  }

  void _pushRoute(ClientHomeRoute route, {bool addToRouteStack = true}) {
    if (addToRouteStack) {
      _routeStack.add(route);
    }
    emit(route);
  }

  // Pop the top route from the stack.
  void _popRoute() {
    if (_routeStack.isNotEmpty) {
      _routeStack.removeLast();
      final previousRoute =
          _routeStack.isNotEmpty ? _routeStack.last : const HomeRoute();
      emit(previousRoute);
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
        ProfileRoute route = initialRoute as ProfileRoute;
        goToProfile(route.extraPagePath);
        break;
      case ProductDetailsRoute:
        ProductDetailsRoute route = initialRoute as ProductDetailsRoute;
        goToProductDetails(route.productId);
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
