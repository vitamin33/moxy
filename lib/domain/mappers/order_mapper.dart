import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';

import '../../constant/order_constants.dart';
import '../../data/models/request/create_order_request.dart';
import '../../data/models/response/all_orders_response.dart';
import '../../services/get_it.dart';
import '../models/city.dart';
import '../models/order.dart';

class OrderMapper {
  final productMapper = locate<ProductMapper>();
  List<Order> mapToOrderList(List<NetworkOrder> networkOrders) {
    return networkOrders.map((o) {
      return Order(
        ukrPostNumber: o.ukrPostNumber,
        deliveryType: _mapDeliveryType(o.deliveryType),
        status: o.status,
        paymentType: _mapPaymentType(o.paymentType),
        client: Client(
          mobileNumber: o.client.mobileNumber,
          firstName: o.client.firstName,
          secondName: o.client.secondName,
          city: o.client.city,
        ),
        orderedItems: productMapper.mapToOrderedItemList(o.orderedItems),
        createdAt: o.createdAt,
        updatedAt: o.updatedAt,
      );
    }).toList();
  }

  List<OrderedItem> mapProductsToOrderedItemList(List<Product> products) {
    return products.where((source) {
      return source.id != null;
    }).map((product) {
      final firstImage =
          product.images.isEmpty ? null : product.images.first.imagePath;
      return OrderedItem(
        productId: product.id!,
        productName: product.name,
        dimensions: product.dimensions,
        imageUrl: firstImage,
      );
    }).toList();
  }

  PaymentType _mapPaymentType(String paymentType) {
    switch (paymentType) {
      case 'cashAdvance':
        return PaymentType.cashAdvance;
      case 'fullPayment':
        return PaymentType.fullPayment;
    }
    return PaymentType.fullPayment;
  }

  DeliveryType _mapDeliveryType(String paymentType) {
    switch (paymentType) {
      case 'novaPost':
        return DeliveryType.novaPost;
      case 'ukrPost':
        return DeliveryType.ukrPost;
    }
    return DeliveryType.novaPost;
  }

  CreateOrder mapToNetworkCreateOrder(
    DeliveryType deliveryType,
    PaymentType paymentType,
    List<OrderedItem> selectedProduct,
    Client client,
    City city,
    String status,
  ) {
    return CreateOrder(
      deliveryType: deliveryType,
      paymentType: paymentType,
      // TODO  data for this object should be set to real data
      novaPost: NetworkNovaPost(
          number: 23,
          ref: 'test_ref',
          postMachineType: 'test_post_mashine_type'),
      status: status,
      client: NetworkClient(
        client.city,
        client.firstName,
        client.mobileNumber,
        client.secondName,
      ),
      city: NetworkCity(
        ref: city.ref,
        mainDescription: city.mainDescription,
        deliveryCityRef: city.deliveryCityRef,
        presentName: city.presentName,
      ),
      products: selectedProduct.map(
        (e) {
          List<Dimension> list = e.dimensions;
          return NetworkOrderedItem(
            id: e.productId,
            dimensions: list.map((d) {
              return NetworkDimension(color: d.color, quantity: d.quantity);
            }).toList(),
          );
        },
      ).toList(),
    );
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

