import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/product.dart';

import '../../constant/order_constants.dart';
import '../../data/models/request/create_order_request.dart';
import '../../data/models/request/edit_order_request.dart';
import '../../data/models/response/all_orders_response.dart';
import '../../services/get_it.dart';
import '../models/city.dart';
import '../models/order.dart';
import '../models/warehouse.dart';

class OrderMapper {
  final productMapper = locate<ProductMapper>();
  List<Order> mapToOrderList(List<NetworkOrder> networkOrders) {
    return networkOrders.map((o) {
      return Order(
        id: o.id,
        cashAdvanceValue: o.cashAdvanceValue,
        novaPost: o.novaPost,
        city: City(
            mainDescription: o.city.mainDescription!,
            ref: o.city.ref!,
            deliveryCityRef: o.city.deliveryCityRef!,
            presentName: o.city.presentName!),
        deliveryType: _mapDeliveryType(o.deliveryType),
        status: o.status,
        paymentType: _mapPaymentType(o.paymentType),
        client: Client(
          id: o.client.id,
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
      case 'CashAdvance':
        return PaymentType.cashAdvance;
      case 'FullPayment':
        return PaymentType.fullPayment;
    }
    return PaymentType.fullPayment;
  }

  String _mapPaymentTypeNetwork(String paymentType) {
    switch (paymentType) {
      case 'cashAdvance':
        return 'CashAdvance';
      case 'fullPayment':
        return 'FullPayment';
    }
    return 'CashAdvance';
  }

  DeliveryType _mapDeliveryType(String paymentType) {
    switch (paymentType) {
      case 'NovaPost':
        return DeliveryType.novaPost;
      case 'UkrPost':
        return DeliveryType.ukrPost;
    }
    return DeliveryType.novaPost;
  }

  String _mapDeliveryTypeNetwork(String paymentType) {
    switch (paymentType) {
      case 'novaPost':
        return 'NovaPost';
      case 'ukrPost':
        return 'UkrPost';
    }
    return 'NovaPost';
  }

  CreateOrder mapToNetworkCreateOrder(
      DeliveryType deliveryType,
      PaymentType paymentType,
      List<OrderedItem> selectedProduct,
      Warehouse novapost,
      Client client,
      City city,
      String status,
      String prepayment) {
    return CreateOrder(
      cashAdvanceValue: int.parse(prepayment),
      deliveryType: _mapDeliveryTypeNetwork(deliveryType.name),
      paymentType: _mapPaymentTypeNetwork(paymentType.name),
      novaPost: NetworkNovaPost(
          number: novapost.number,
          ref: novapost.ref,
          postMachineType: novapost.postMachineType,
          presentName: novapost.description),
      status: status,
      client: NetworkClient(
        city: client.city,
        firstName: client.firstName,
        mobileNumber: client.mobileNumber,
        secondName: client.secondName,
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

  EditOrder mapToNetworkEditOrder(
      String orderId,
      DeliveryType deliveryType,
      PaymentType paymentType,
      List<OrderedItem> selectedProduct,
      Warehouse novapost,
      Client client,
      City city,
      String status,
      String prepayment) {
    return EditOrder(
      orderId: orderId,
      cashAdvanceValue: int.parse(prepayment),
      deliveryType: _mapDeliveryTypeNetwork(deliveryType.name),
      paymentType: _mapPaymentTypeNetwork(paymentType.name),
      novaPost: NetworkNovaPost(
          number: novapost.number,
          ref: novapost.ref,
          postMachineType: novapost.postMachineType,
          presentName: novapost.description),
      status: status,
      client: NetworkClient(
        id: client.id,
        city: client.city,
        firstName: client.firstName,
        mobileNumber: client.mobileNumber,
        secondName: client.secondName,
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
