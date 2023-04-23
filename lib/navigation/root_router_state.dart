
part of 'root_router_cubit.dart';

abstract class RootRouterState extends Equatable {
  const RootRouterState();
  @override
  List<Object?> get props => [];
}

class MainPageState extends RootRouterState {
  final String? extraPageContent;
  const MainPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class AuthPageState extends RootRouterState {
  final String? extraPageContent;
  const AuthPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}
