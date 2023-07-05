import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../constant/order_constants.dart';
import '../../models/city.dart';
import '../../models/order.dart';
import '../../models/warehouse.dart';
import 'filter_orders_state.dart';

class FilterOrdersCubit extends Cubit<FilterOrdersState> {
  FilterOrdersCubit()
      : super(FilterOrdersState(
            isLoading: false,
            isSuccess: false,
            isEditName: false,
            isEditPhone: false,
            errorMessage: '',
            orderId: '',
            deliveryType: DeliveryType.novaPost,
            paymentType: PaymentType.fullPayment,
            selectedProducts: [],
            selectedCity: City.defaultCity(),
            selectedWarehouse: Warehouse.defaultWarehouse(),
            client: Client.defaultClient(),
            status: 'New',
            prepayment: 150,
            createdAt: '',
            updatedAt: ''));
}
