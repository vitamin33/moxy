import 'package:dio/dio.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/data/models/request/create_order_request.dart';
import 'package:moxy/data/models/request/edit_order_request.dart';
import 'package:moxy/data/models/request/find_orders_request.dart';
import 'package:moxy/data/models/response/all_orders_response.dart';
import 'package:moxy/domain/models/filter_order_param.dart';
import 'package:moxy/environment.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/extensions.dart';

class OrderService {
  final baseUrl = Environment.apiUrl;
  final Dio _dio;

  OrderService(this._dio);

  Future<List<NetworkOrder>> paginatedAllOrders([int page = 1]) async {
    try {
      final response = await _dio.get('$baseUrl$allOrdersUrl?page=$page');
      final data = response.data;
      final orderList = <NetworkOrder>[];
      for (var value in (data as List)) {
        orderList.add(NetworkOrder.fromJson(value));
      }
      return orderList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<List<NetworkOrder>> paginatedFilterOrders(FilterOrderParams params,
      [int page = 1]) async {
    FindOrders find =
        FindOrders(statuses: [], paymentTypes: [], deliveryTypes: []);
    final deliveryType = params.deliveryType;
    if (deliveryType != FilterDeliveryType.empty) {
      find.deliveryTypes.add(deliveryType.capitalizedName);
    }
    final paymentType = params.paymentType;
    if (paymentType != FilterPaymentType.empty) {
      find.paymentTypes.add(paymentType.capitalizedName);
    }
    final statuses = params.statuses;
    if (statuses.isNotEmpty) {
      for (var status in statuses) {
        find.statuses.add(status.statusValue.name);
      }
    }
    final dateRange = params.dateRange?.toString();
    final startData = dateRange?.split(' - ')[0].split(' ')[0];
    find.fromDate = startData;
    final endData = dateRange?.split(' - ')[1].split(' ')[0];
    find.toDate = endData;

    try {
      final response = await _dio.post(
        '$baseUrl$findOrdersUrl?page=$page',
        data: find.toJson(),
      );
      final data = response.data;
      final orderList = <NetworkOrder>[];
      for (var value in (data as List)) {
        orderList.add(NetworkOrder.fromJson(value));
      }
      return orderList;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<NetworkOrder> getOrderById(String orderId) async {
    try {
      final response = await _dio.get('$baseUrl$orderByIdUrl$orderId');
      final data = response.data;
      return NetworkOrder.fromJson(data);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<NetworkOrder> createOrder(CreateOrder order) async {
    try {
      final data = order.toJson();
      Response response = await _dio.post(
        createOrdersUrl,
        data: data,
      );
      return NetworkOrder.fromJson(response.data);
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Headers> editOrder(EditOrder order) async {
    final Headers? result;
    final data = order.toJson();
    try {
      Response response = await _dio.post(
        editOrdersUrl,
        data: data,
      );
      result = response.headers;
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Headers> editOrderStatus(EditStatusOrder order) async {
    final Headers? result;
    final data = order.toJson();
    try {
      Response response = await _dio.post(
        editOrdersUrl,
        data: data,
      );
      result = response.headers;
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<bool> deleteOrder(String orderId) async {
    try {
      Response response = await _dio.delete(
        '$orderByIdUrl$orderId',
      );
      int code = response.statusCode ?? 0;
      return code.isSuccessful();
    } catch (e, stack) {
      moxyPrint(stack);
      return false;
    }
  }
}
