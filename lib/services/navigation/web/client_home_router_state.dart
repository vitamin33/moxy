part of 'client_home_router_cubit.dart';

const String shopPrefix = 'shop/';

abstract class ClientHomeRoute extends Equatable {
  static const String homePath = 'home';
  static const String homeBagsPath = 'bags';
  static const String accessoriesPath = 'accessories';
  static const String favoritesPath = 'favorites';
  static const String checkoutPath = 'checkout';
  static const String profilePath = 'profile';
  static const String productDetailsPath = 'profile';

  static const int secondTabIndex = 1;
  static const int thirdTabIndex = 2;

  const ClientHomeRoute();
  @override
  List<Object?> get props => [];

  String urlPath();

  factory ClientHomeRoute.fromUri(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      return const HomeRoute();
    } else if (uri.pathSegments.length == 2) {
      String second = uri.pathSegments[1];
      switch (second) {
        case favoritesPath:
          return const FavouritesRoute();
        case profilePath:
          return const ProfileRoute();
        case checkoutPath:
          return const CheckoutRoute();
        case productDetailsPath:
          return const ProductDetailsRoute();
        case homeBagsPath:
          return const HomeRoute(secondTabIndex);
        case accessoriesPath:
          return const HomeRoute(thirdTabIndex);
        default:
          return const HomeRoute();
      }
    }
    return const HomeRoute();
  }
}

class HomeRoute extends ClientHomeRoute {
  final int? tabIndex;
  const HomeRoute([this.tabIndex]);
  @override
  List<Object?> get props => [tabIndex];
  @override
  String urlPath() {
    if (tabIndex == 1) {
      return ClientHomeRoute.homeBagsPath;
    } else if (tabIndex == 2) {
      return ClientHomeRoute.accessoriesPath;
    } else {
      return ClientHomeRoute.homePath;
    }
  }
}

class FavouritesRoute extends ClientHomeRoute {
  final String? extraPageContent;
  const FavouritesRoute([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
  @override
  String urlPath() => ClientHomeRoute.favoritesPath;
}

class CheckoutRoute extends ClientHomeRoute {
  final String? extraPageContent;
  const CheckoutRoute([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
  @override
  String urlPath() => ClientHomeRoute.checkoutPath;
}

class ProfileRoute extends ClientHomeRoute {
  final String? extraPageContent;
  const ProfileRoute([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
  @override
  String urlPath() => ClientHomeRoute.profilePath;
}

class ProductDetailsRoute extends ClientHomeRoute {
  final String? extraPageContent;
  const ProductDetailsRoute([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
  @override
  String urlPath() => ClientHomeRoute.productDetailsPath;
}
