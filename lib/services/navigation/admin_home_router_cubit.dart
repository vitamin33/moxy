import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_home_router_state.dart';

class AdminHomeRouterCubit extends Cubit<AdminHomeRouterState> {
  AdminHomeRouterCubit() : super(const OverviewPageState());
  void goToProducts([String? text]) => emit(ProductsPageState(text));
  void goToOverview([String? text]) => emit(OverviewPageState(text));
  void goToCustomers([String? text]) => emit(UsersPageState(text));
  void goToOrders([String? text]) => emit(OrdersPageState(text));
  void goToTransactions([String? text]) => emit(TransactionsPageState(text));
  void goToFeedbacks([String? text]) => emit(FeedbacksPageState(text));
  void goToCreateProduct([bool? isEdit, String? editProductId]) => emit(
      CreateProductPageState(isEditMode: isEdit, editProductId: editProductId));
  void goToCreateOrder([String? text]) => emit(CreateOrderPageState(text));
  void goToEditOrder([String? text]) => emit(EditOrderPageState(text));
  void goToOrderProductList([bool isFromEdit = false]) =>
      emit(OrderProductListPageState(isFromEdit: isFromEdit));
  void goToFilterOrder([String? text]) => emit(FilterOrderPageState(text));
  void goToCreateUser([String? text]) => emit(CreateUserPageState(text));
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

  void navigateTo(AdminHomeRouterState initialRoute) {
    switch (initialRoute.runtimeType) {
      case OverviewPageState:
        goToOverview();
        break;
      case ProductsPageState:
        goToProducts();
        break;
      case UsersPageState:
        goToCustomers();
        break;
      case OrdersPageState:
        goToOrders();
        break;
      case CreateProductPageState:
        final state = initialRoute as CreateProductPageState;
        goToCreateProduct(state.isEditMode, state.editProductId);
        break;
      case CreateOrderPageState:
        goToCreateOrder();
        break;
      case EditOrderPageState:
        goToEditOrder();
        break;
      case FilterOrderPageState:
        goToFilterOrder();
        break;
      case OrderProductListPageState:
        final state = initialRoute as OrderProductListPageState;
        goToOrderProductList(state.isFromEdit);
        break;
      case CreateUserPageState:
        goToCreateUser();
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
