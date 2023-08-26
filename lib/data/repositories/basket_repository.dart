import 'package:moxy/data/http/basket_service.dart';
import 'package:multiple_result/multiple_result.dart';

import '../../services/get_it.dart';

class BasketRepository {
  BasketRepository();
  final BasketService client = locate<BasketService>();

  Future<Result<dynamic, Exception>> getBasket() async {
    try {
      final result = await client.getBasket();
      return Result.success(result);
    } catch (e) {
      return Result.error(Exception('$e'));
    }
  }
}
