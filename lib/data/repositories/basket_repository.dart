import 'package:moxy/data/http/basket_service.dart';
import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:moxy/domain/mappers/basket_mapper.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/created_invoice.dart';
import 'package:moxy/utils/common.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';

class BasketRepository {
  BasketRepository();
  final BasketService client = locate<BasketService>();
  final BasketMapper mapper = locate<BasketMapper>();

  Future<Result<NetworkBasket, Exception>> getBasket() async {
    try {
      final result = await client.getBasket();
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<NetworkBasket, Exception>> changeBasketProductDimen(
      NetworkAddOrChange change) async {
    try {
      final result = await client.addOrChangeQuantityOfProduct(change);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Result<Object, Exception>> addProductToBasket(
      NetworkAddOrChange change) async {
    try {
      final result = await client.addProductToBasket(change);
      return result;
    } catch (e, stack) {
      moxyPrint(stack);
      rethrow;
    }
  }

  Future<Result<NetworkBasket, Exception>> removeProductFromBasket(
      NetworkRemoveProduct remove) async {
    try {
      final result = await client.removeProductFromBasket(remove);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<Result<CreatedInvoice, Exception>> startPayment(Basket basket) async {
    try {
      final createInvoice = mapper.mapToNetworkCreateInvoice(basket);
      final result = await client.startPayment(createInvoice);
      return Result.success(mapper.mapToCreatedInvoice(result));
    } catch (e) {
      rethrow;
    }
  }
}
