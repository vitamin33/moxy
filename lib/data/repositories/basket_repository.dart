import 'package:moxy/data/http/basket_service.dart';
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
}
