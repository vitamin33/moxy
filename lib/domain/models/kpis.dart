// Import the response model
import 'package:moxy/data/models/response/dashboard_response.dart';

class Kpis {
  double avgOrderValue;
  double avgOrderValuePrev;
  double avgOrderProfit;
  double avgOrderProfitPrev;
  double ltgpToCacRatio;
  double ltgpToCacRatioPrev;

  Kpis({
    required this.avgOrderValue,
    required this.avgOrderValuePrev,
    required this.avgOrderProfit,
    required this.avgOrderProfitPrev,
    required this.ltgpToCacRatio,
    required this.ltgpToCacRatioPrev,
  });

  factory Kpis.defaultKpis() {
    return Kpis(
      avgOrderValue: 0.0,
      avgOrderValuePrev: 0.0,
      avgOrderProfit: 0.0,
      avgOrderProfitPrev: 0.0,
      ltgpToCacRatio: 0.0,
      ltgpToCacRatioPrev: 0.0,
    );
  }

  factory Kpis.fromResponse(KpisResponse dto) {
    return Kpis(
      avgOrderValue: double.parse(dto.avgOrderValue),
      avgOrderValuePrev: double.parse(dto.avgOrderValuePrev),
      avgOrderProfit: double.parse(dto.avgOrderProfit),
      avgOrderProfitPrev: double.parse(dto.avgOrderProfitPrev),
      ltgpToCacRatio: double.parse(dto.ltgpToCacRatio),
      ltgpToCacRatioPrev: double.parse(dto.ltgpToCacRatioPrev),
    );
  }
}
