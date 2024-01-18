import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/repositories/filter_repository.dart';
import 'package:moxy/data/repositories/order_repository.dart';
import 'package:moxy/domain/admin/all_orders/all_orders_state.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../../services/get_it.dart';
import '../../mappers/order_mapper.dart';
import '../../models/order.dart';
import '../../models/status.dart';

class AllOrdersCubit extends Cubit<AllOrdersState> {
  final filterRepository = locate<FilterRepository>();
  final ordersRepository = locate<OrderRepository>();
  final orderMapper = locate<OrderMapper>();
  List<Order> allOrdersList = [];

  late final StreamSubscription _filterOrderSubscription;

  AllOrdersCubit() : super(AllOrdersState.defaultAllProductsState()) {
    checkFilters();
    fetchOrders();
    _subscribe();
  }

  void _subscribe() {
    _filterOrderSubscription =
        filterRepository.filterParamsStream.listen((filterState) {
      checkFilters();
      fetchOrders(1, false, true);
    });
  }

  @override
  Future<void> close() {
    _filterOrderSubscription.cancel();
    return super.close();
  }

  void fetchOrders([
    int page = 1,
    bool fromRefresh = false,
    bool clearOldHistory = false,
  ]) async {
    try {
      emit(state.copyWith(isLoading: true));
      Result<List<Order>, Exception> result;

      if (state.hasFilters()) {
        result = await ordersRepository.getPaginatedFilterOrders(page);
      } else {
        result = await ordersRepository.getPaginatedAllOrders(page);
      }

      result.when((success) {
        List<Order> fullList;
        if (clearOldHistory) {
          fullList = success;
        } else {
          fullList = state.allOrders.combineOrders(success);
        }
        allOrdersList = fullList;
        emit(state.copyWith(
          allOrders: fullList,
          currentPage: fromRefresh ? state.currentPage : page,
          hasMoreOrders: fromRefresh ? state.hasMoreOrders : success.isNotEmpty,
          isLoading: false,
        ));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed fetching orders'));
      });
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  void checkFilters() {
    final filters = filterRepository.getFilterParams();
    emit(state.copyWith(
      paymentFilter: filters.paymentType,
      deliveryFilter: filters.deliveryType,
      statusFilter: filters.statuses,
      dateRangeFilter: filters.dateRange,
    ));
  }

  void searchOrders(String searchTerm) {
    final filteredList = allOrdersList.where((element) {
      final client = element.client;
      final orderedItems = element.orderedItems;
      return client.firstName
              .toLowerCase()
              .contains(searchTerm.toLowerCase()) ||
          client.secondName.toLowerCase().contains(searchTerm.toLowerCase()) ||
          client.mobileNumber
              .toLowerCase()
              .contains(searchTerm.toLowerCase()) ||
          orderedItems.any((item) => item.productName
              .toLowerCase()
              .contains(searchTerm.toLowerCase()));
    }).toList();
    emit(state.copyWith(allOrders: filteredList));
  }

  void updateStatusTitles(
      List<Status> allOrdersStatus, List<Status> filterOrder) {
    List<Status> result = [];
    for (var firstStatus in allOrdersStatus) {
      for (var secondStatus in filterOrder) {
        if (firstStatus.statusValue == secondStatus.statusValue) {
          result.add(Status(
              iconPath: firstStatus.iconPath,
              isSelected: firstStatus.isSelected,
              statusTitle: secondStatus.statusTitle,
              statusValue: secondStatus.statusValue));

          break;
        }
      }
    }
    emit(state.copyWith(statusFilter: result));
  }

  void clearDeliveryTypeFilter() async {
    filterRepository.clearDeliveryTypeFilter();
    emit(state.copyWith(deliveryFilter: FilterDeliveryType.empty));
  }

  void clearPaymentTypeFilter() {
    filterRepository.clearPaymentTypeFilter();
    emit(state.copyWith(paymentFilter: FilterPaymentType.empty));
  }

  void clearStatusFilter() {
    filterRepository.clearStatusFilter();
    emit(state.copyWith(statusFilter: []));
    moxyPrint(state.statusFilter);
  }

  void clearDateRangeFilter() {
    filterRepository.clearDateRangeFilter();
    emit(state.copyWith(shouldSetDateRangeFilterToNull: true));
  }

  Future<void> refreshOrderList() async {
    fetchOrders(1, true);
  }

  void changedStatus(Status status, String id) {
    final updateAllOrders = state.allOrders.map((element) {
      if (element.id == id) {
        return Order(
          cashAdvanceValue: element.cashAdvanceValue,
          novaPost: element.novaPost,
          city: element.city,
          deliveryType: element.deliveryType,
          status: status,
          paymentType: element.paymentType,
          client: element.client,
          orderedItems: element.orderedItems,
          createdAt: element.createdAt,
          updatedAt: element.createdAt,
          ukrPostInfo: element.ukrPostInfo,
        );
      } else {
        return element;
      }
    }).toList();
    emit(state.copyWith(allOrders: updateAllOrders));
    editOrderStatus(status, id);
  }

  void editOrderStatus(Status status, String id) async {
    try {
      final order =
          orderMapper.mapToNetworkEditStatusOrder(id, status.statusValue.name);
      final result = await ordersRepository.editOrderStatus(order);
      result.when((success) {
        moxyPrint(success);
      }, (error) {
        emit(state.copyWith(
          errorMessage: 'Failed',
        ));
      });
    } catch (e) {
      moxyPrint(e);
    }
  }

  void deleteOrder(String? orderId, int index) async {
    if (orderId != null) {
      final updatedOrders = List<Order>.from(state.allOrders)..removeAt(index);

      emit(state.copyWith(allOrders: updatedOrders, isLoading: true));
      final result = await ordersRepository.deleteOrder(orderId);
      result.when((success) {
        refreshOrderList();
      }, (error) {
        emit(state.copyWith(
          errorMessage: 'Failed',
        ));
        refreshOrderList();
      });
    }
  }
}
