import 'package:moxy/constants.dart';
import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/request/mono_create_invoice_request.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/data/models/response/mono_create_invoice_response.dart';
import 'package:moxy/domain/client/checkout/payment_config.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/mappers/user_mapper.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/created_invoice.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/product_details.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/extensions.dart';

class BasketMapper {
  final productMapper = locate<ProductMapper>();
  final userMapper = locate<UserMapper>();

  Basket mapToBasket(NetworkBasket network) {
    List<BasketItem> items = [];
    for (NetworkBasketItem item in network.basketItems) {
      if (item.dimensions.length > 1) {
        for (NetworkDimension dimen in item.dimensions) {
          Dimension toAdd = productMapper.mapToDimension(dimen);
          items.add(
            BasketItem(
                product: productMapper.mapToProduct(item.product),
                dimension: toAdd),
          );
        }
      } else {
        Dimension toAdd = productMapper.mapToDimension(item.dimensions[0]);
        items.add(
          BasketItem(
              product: productMapper.mapToProduct(item.product),
              dimension: toAdd),
        );
      }
    }
    return Basket(
      id: network.id,
      client: network.client?.let((it) => userMapper.mapToProfileUser(it)),
      basketItems: items,
      freeShippingThreshold: network.freeShippingThreshold,
    );
  }

  CreateInvoiceRequest mapToNetworkCreateInvoice(
      Basket basket, String newOrderId, String userId) {
    final merchantInfo = mapToMerchantInfo(basket, newOrderId, userId);
    return CreateInvoiceRequest(
      amount: basket.totalValue().convertToPenny(),
      ccy: 980, // UAH code, default 980
      redirectUrl: paymentRedirectUrl,
      paymentType: 'debit',
      webHookUrl: paymentInvoiceUpdateUrl,
      merchantPaymInfo: merchantInfo,
    );
  }

  NetworkMerchantInfo mapToMerchantInfo(
      Basket basket, String orderId, String userId) {
    List<MonoBasketItem> basketOrder = [];
    for (BasketItem item in basket.basketItems) {
      MonoBasketItem monoItem = MonoBasketItem(
        name: '${item.product.name} ${item.dimension.color.name}',
        qty: item.dimension.quantity,
        sum: item.product.salePrice.toInt().convertToPenny(),
        icon: item.dimension.images.first.imagePath,
        code: item.product.id ?? item.product.idName,
        unit: piece,
      );
      basketOrder.add(monoItem);
    }
    return NetworkMerchantInfo(
        reference:
            '$orderId $userId', // Its important - Format: 'orderId userId'
        basketOrder: basketOrder,
        comment: 'comment',
        destination: 'destination');
  }

  CreatedInvoice mapToCreatedInvoice(NetworkCreateInvoiceResponse network) {
    return CreatedInvoice(
      invoiceId: network.invoiceId,
      pageUrl: network.pageUrl,
    );
  }

  NetworkAddOrChange mapToNetworkBasketChange(BasketItem item) {
    return NetworkAddOrChange(
      product: NetworkChangeBasketDimen(
        productId: item.product.id!,
        dimension: productMapper.mapToNetworkDimension(item.dimension),
      ),
    );
  }

  NetworkAddOrChange productDetailsMapToNetworkBasketChange(
      ProductDetails item) {
    return NetworkAddOrChange(
      product: NetworkChangeBasketDimen(
        productId: item.product.id!,
        dimension: productMapper.mapToNetworkDimension(item.dimension),
      ),
    );
  }

  NetworkAddOrChange productMapToNetworkBasketChange(Product product) {
    return NetworkAddOrChange(
      product: NetworkChangeBasketDimen(
        productId: product.id!,
        dimension:
            productMapper.mapToNetworkDimension(product.dimensions.first),
      ),
    );
  }

  List<OrderedItem> mapToOrderedItems(List<BasketItem> basketItems) {
    List<OrderedItem> result = [];

    for (BasketItem basketItem in basketItems) {
      OrderedItem existingOrderedItem = result.firstWhere(
        (item) => item.productId == basketItem.product.id,
        orElse: () => OrderedItem(
          productId: basketItem.product.id,
          productName: basketItem.product.name,
          dimensions: [], // Initialize with an empty list of dimensions
          productPrice: basketItem.product.salePrice.toString(),
        ),
      );

      // Append the dimension to the existing OrderedItem
      existingOrderedItem.dimensions.add(basketItem.dimension);

      // Replace the existing OrderedItem in the result list (if found)
      result.remove(existingOrderedItem);
      result.add(existingOrderedItem);
    }

    return result;
  }
}
