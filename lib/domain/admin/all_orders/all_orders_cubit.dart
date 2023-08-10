import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/repositories/filter_repository.dart';
import 'package:moxy/data/repositories/order_repository.dart';
import 'package:moxy/domain/admin/all_orders/all_orders_state.dart';
import 'package:moxy/utils/common.dart';

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
    allOrders();
    _subscribe();
  }

  void _subscribe() {
    _filterOrderSubscription =
        filterRepository.filterParamsStream.listen((filterState) {
      allOrders();
    });
  }

  @override
  Future<void> close() {
    _filterOrderSubscription.cancel();
    return super.close();
  }

  void allOrders() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await ordersRepository.getAllOrders();
      checkFilters();
      result.when((success) {
        allOrdersList = success;
        emit(state.copyWith(allOrders: success, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed getAllProduct'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  checkFilters() {
    final filters = filterRepository.getFilterParams();
    emit(state.copyWith(
      paymentFilter: filters.paymentType,
      deliveryFilter: filters.deliveryType,
      statusFilter: filters.status,
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
    allOrders();
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
            updatedAt: element.createdAt);
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
}
