import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/request/mono_create_invoice_request.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/data/models/response/mono_create_invoice_response.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/created_invoice.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/get_it.dart';

class BasketMapper {
  final productMapper = locate<ProductMapper>();

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
        client: network.client,
        basketItems: items,
        freeShippingThreshold: network.freeShippingThreshold);
  }

  CreateInvoiceRequest mapToNetworkCreateInvoice(Basket basket) {
    final merchantInfo = mapToMerchantInfo(basket);
    return CreateInvoiceRequest(
      amount: basket.totalValue(),
      ccy: 980, // UAH code, default 980
      redirectUrl: 'redirect_url',
      paymentType: 'debit',
      webHookUrl: 'web_hook_url',
      merchantPaymInfo: merchantInfo,
    );
  }

  NetworkMerchantInfo mapToMerchantInfo(Basket basket) {
    List<MonoBasketItem> basketOrder = [];
    return NetworkMerchantInfo(
        reference: basket.id,
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

  NetworkAddOrChange productMapToNetworkBasketChange(Product product) {
    return NetworkAddOrChange(
      product: NetworkChangeBasketDimen(
        productId: product.id!,
        dimension:
            productMapper.mapToNetworkDimension(product.dimensions.first),
      ),
    );
  }
}
