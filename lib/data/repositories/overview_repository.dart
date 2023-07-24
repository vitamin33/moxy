import 'package:multiple_result/multiple_result.dart';

import '../../utils/common.dart';

class OverviewRepository {
  OverviewRepository();

  Future<Result<dynamic, Exception>> getOverview(order) async {
    try {
      return Result.success('result');
    } catch (e) {
      moxyPrint('Repository Error:$e');
      return Result.error(Exception('$e'));
    }
  }
}
