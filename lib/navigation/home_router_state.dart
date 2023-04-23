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
  final String? extraPageContent;
  const CreateProductPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class OverviewPageState extends HomeRouterState {
  final String? extraPageContent;
  const OverviewPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class CustomersPageState extends HomeRouterState {
  final String? extraPageContent;
  const CustomersPageState([this.extraPageContent]);
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
  final String? extraPageContent;
  const CreateOrderPageState([this.extraPageContent]);
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
