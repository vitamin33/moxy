part of 'home_router_cubit.dart';

abstract class HomeRouterState extends Equatable {
  const HomeRouterState();
  @override
  List<Object?> get props => [];
}

class ProductsPageState extends HomeRouterState {
  final String? extraPageContent;
  const ProductsPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class CreateProductPageState extends HomeRouterState {
  final bool? isEditMode;
  final String? editProductId;
  const CreateProductPageState({this.isEditMode, this.editProductId});
  @override
  List<Object?> get props => [isEditMode, editProductId];
}

class OverviewPageState extends HomeRouterState {
  final String? extraPageContent;
  const OverviewPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class UsersPageState extends HomeRouterState {
  final String? extraPageContent;
  const UsersPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class CreateUserPageState extends HomeRouterState {
  final String? extraPageContent;
  const CreateUserPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class OrdersPageState extends HomeRouterState {
  final String? extraPageContent;
  const OrdersPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class CreateOrderPageState extends HomeRouterState {
  final bool? isEditMode;
  const CreateOrderPageState({this.isEditMode, });
  @override
  List<Object?> get props => [isEditMode];
}
class OrderProductListPageState extends HomeRouterState {
  final String? extraPageContent;
  const OrderProductListPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class FeedbacksPageState extends HomeRouterState {
  final String? extraPageContent;
  const FeedbacksPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class TransactionsPageState extends HomeRouterState {
  final String? extraPageContent;
  const TransactionsPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class EmptyState extends HomeRouterState {
  const EmptyState();
}
