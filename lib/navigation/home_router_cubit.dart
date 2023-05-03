import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_router_state.dart';

class HomeRouterCubit extends Cubit<HomeRouterState> {
  HomeRouterCubit() : super(const OverviewPageState());
  void goToProducts([String? text]) => emit(ProductsPageState(text));
  void goToOverview([String? text]) => emit(OverviewPageState(text));
  void goToCustomers([String? text]) => emit(CustomersPageState(text));
  void goToOrders([String? text]) => emit(OrdersPageState(text));
  void goToTransactions([String? text]) => emit(TransactionsPageState(text));
  void goToFeedbacks([String? text]) => emit(FeedbacksPageState(text));
  void goToCreateProduct([String? text]) => emit(CreateProductPageState(text));
  void goToCreateOrder([String? text]) => emit(CreateOrderPageState(text));
  void popExtra() {
    if (state is OverviewPageState) {
      goToOverview();
    } else if (state is FeedbacksPageState) {
      goToCustomers();
    } else if (state is TransactionsPageState) {
      goToOrders();
    } else {
      goToProducts();
    }
  }

  void navigateTo(HomeRouterState initialRoute) {
    switch (initialRoute.runtimeType) {
      case OverviewPageState:
        goToOverview();
        break;
      case ProductsPageState:
        goToProducts();
        break;
      case CustomersPageState:
        goToCustomers();
        break;
      case OrdersPageState:
        goToOrders();
        break;
      case CreateProductPageState:
        goToCreateProduct();
        break;
      case CreateOrderPageState:
        goToCreateOrder();
        break;
      case TransactionsPageState:
        goToTransactions();
        break;
      case FeedbacksPageState:
        goToFeedbacks();
        break;
    }
  }
}