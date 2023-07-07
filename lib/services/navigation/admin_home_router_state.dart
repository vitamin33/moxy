part of 'admin_home_router_cubit.dart';

abstract class AdminHomeRouterState extends Equatable {
  const AdminHomeRouterState();
  @override
  List<Object?> get props => [];
}

class ProductsPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const ProductsPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class CreateProductPageState extends AdminHomeRouterState {
  final bool? isEditMode;
  final String? editProductId;
  const CreateProductPageState({this.isEditMode, this.editProductId});
  @override
  List<Object?> get props => [isEditMode, editProductId];
}

class OverviewPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const OverviewPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class UsersPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const UsersPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class CreateUserPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const CreateUserPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class OrdersPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const OrdersPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class CreateOrderPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const CreateOrderPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class EditOrderPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const EditOrderPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class FilterOrderPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const FilterOrderPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class OrderProductListPageState extends AdminHomeRouterState {
  final bool isFromEdit;
  final String? extraPageContent;
  const OrderProductListPageState(
      {this.extraPageContent, required this.isFromEdit});
  @override
  List<Object?> get props => [extraPageContent];
}

class FeedbacksPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const FeedbacksPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class TransactionsPageState extends AdminHomeRouterState {
  final String? extraPageContent;
  const TransactionsPageState([this.extraPageContent]);
  @override
  List<Object?> get props => [extraPageContent];
}

class EmptyState extends AdminHomeRouterState {
  const EmptyState();
}
