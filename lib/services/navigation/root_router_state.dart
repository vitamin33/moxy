part of 'root_router_cubit.dart';

abstract class RootRouterState extends Equatable {
  const RootRouterState();
  @override
  List<Object?> get props => [];
}

class AdminPageState extends RootRouterState {
  final String? extraPageContent;
  const AdminPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class ClientPageState extends RootRouterState {
  final String? extraPageContent;
  const ClientPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class AuthPageState extends RootRouterState {
  final String? extraPageContent;
  const AuthPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
