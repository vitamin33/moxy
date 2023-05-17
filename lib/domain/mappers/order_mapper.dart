import 'package:moxy/domain/mappers/product_mapper.dart';

import '../../data/models/response/all_orders_response.dart';
import '../../services/get_it.dart';
import '../models/order.dart';

class OrderMapper {
  final productMapper = locate<ProductMapper>();
  List<Order> mapToOrderList(List<NetworkOrder> networkOrders) {
    return networkOrders.map((o) {
      return Order(
          ukrPostNumber: o.ukrPostNumber,
          deliveryType: o.deliveryType,
          status: o.status,
          paymentType: o.paymentType,
          client: o.client,
          products:productMapper.mapToProductList(o.products) ,
          createdAt: o.createdAt,
          updatedAt: o.updatedAt);
    }).toList();
  }
}
