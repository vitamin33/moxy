part of 'web_home_router_cubit.dart';

abstract class ClientHomeRouterState extends Equatable {
  const ClientHomeRouterState();
  @override
  List<Object?> get props => [];
}

class HomeRouteState extends ClientHomeRouterState {
  final String? extraPageContent;
  const HomeRouteState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class FavouritesRouteState extends ClientHomeRouterState {
  final String? extraPageContent;
  const FavouritesRouteState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class CheckoutRouteState extends ClientHomeRouterState {
  final String? extraPageContent;
  const CheckoutRouteState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class ProfileRouteState extends ClientHomeRouterState {
  final String? extraPageContent;
  const ProfileRouteState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
