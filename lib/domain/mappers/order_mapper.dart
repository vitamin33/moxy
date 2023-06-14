import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';

import '../../constant/order_constants.dart';
import '../../data/models/request/create_order_request.dart';
import '../../data/models/response/all_orders_response.dart';
import '../../services/get_it.dart';
import '../models/order.dart';
import '../models/product.dart';

class OrderMapper {
  final productMapper = locate<ProductMapper>();
  List<Order> mapToOrderList(List<NetworkOrder> networkOrders) {
    return networkOrders.map((o) {
      return Order(
        ukrPostNumber: o.ukrPostNumber,
        deliveryType: o.deliveryType,
        status: o.status,
        paymentType: o.paymentType,
        client: Client(
          mobileNumber: o.client.mobileNumber,
          firstName: o.client.firstName,
          secondName: o.client.secondName,
          city: o.client.city,
        ),
        products: productMapper.mapToProductList(o.products),
        createdAt: o.createdAt,
        updatedAt: o.updatedAt,
      );
    }).toList();
  }

  CreateOrder mapToNetworkOrder(
      DeliveryType deliveryType,
      PaymentType paymentType,
      List<Product> selectedProduct,
      Client client,
      String status) {
    return CreateOrder(
      deliveryType: deliveryType,
      paymentType: paymentType,
      novaPostNumber: 23,
      status: status,
      client: NetworkClient(client.city, client.firstName, client.mobileNumber,
          client.secondName),
      selectedProducts: selectedProduct
          .map((p) => NetworkProduct(
              name: p.name,
              description: p.description,
              costPrice: p.costPrice,
              salePrice: p.salePrice,
              dimensions: p.dimensions
                  .map((e) =>
                      NetworkDimension(color: e.color, quantity: e.quantity))
                  .toList(),
              idName: p.idName,
              images: p.images.map((e) => e.imagePath).toList()))
          .toList(),
    );
  }
}

