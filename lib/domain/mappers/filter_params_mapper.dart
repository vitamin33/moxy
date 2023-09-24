import 'package:moxy/domain/models/filter_order_param.dart';

import '../admin/filter_orders/filter_orders_state.dart';

class FilterParamsMapper {
  FilterOrderParams mapToFilterParams(FilterOrdersState state) {
    return FilterOrderParams(
        deliveryType: state.deliveryType,
        paymentType: state.paymentType,
        statuses: state.status,
        dateRange: state.selectedDate);
  }
}
