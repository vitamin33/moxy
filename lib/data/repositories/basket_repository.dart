import 'package:moxy/data/http/basket_service.dart';
import 'package:moxy/data/models/request/change_basket_dimen.dart';
import 'package:moxy/data/models/response/basket_response.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';

class BasketRepository {
  BasketRepository();
  final BasketService client = locate<BasketService>();

  Future<Result<NetworkBasket, Exception>> getBasket() async {
    try {
      final result = await client.getBasket();
      return result;
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkBasket, Exception>> changeBasketProductDimen(
      NetworkAddOrChange change) async {
    try {
      final result = await client.addOrChangeQuantityOfProduct(change);
      return result;
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<Object, Exception>> addProductToBasket(
      NetworkAddOrChange change) async {
    try {
      final result = await client.addProductToBasket(change);
      return result;
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkBasket, Exception>> removeProductFromBasket(
      NetworkRemoveProduct remove) async {
    try {
      final result = await client.removeProductFromBasket(remove);
      return result;
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }

  Future<Result<NetworkBasket, Exception>> startPayment() async {
    try {
      final result = await client.startPayment();
      return result;
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }
}
