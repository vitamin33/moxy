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
  }

  // List<Client> mapToClientList(List<NetworkOrder> networkClient) {
  //   return networkClient.map(
  //     (p) {
  //       Map<int, Client> dimenMap = {};
  //       for (var i = 0; i < p.client.length; i++) {
  //         dimenMap.putIfAbsent(
  //             i,
  //             () => Client(
  //                 mobileNumber: p.client[i].mobileNumber,
  //                 quantity: p.dimensions[i].quantity
  //                 ));
  //       }
  //       return Client(
  //         mobileNumber: p.client.mobileNumber,
  //         name: p.name,
  //         description: p.description,
  //         costPrice: p.costPrice,
  //         salePrice: p.salePrice,
  //         dimensions: p.dimensions
  //             .map((e) => Dimension(
  //                   color: e.color,
  //                   quantity: e.quantity,
  //                   image: _mapColorDimensionImage(e),
  //                 ))
  //             .toList(),
  //         idName: p.idName,
  //         images: p.images
  //             .map(
  //               (e) => ImagePath(type: Type.network, imagePath: e),
  //             )
  //             .toList(),
  //       );
  //     },
  //   ).toList();
  // }

