import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../constant/order_constants.dart';
import 'filter_orders_state.dart';

class FilterOrdersCubit extends Cubit<FilterOrdersState> {
  FilterOrdersCubit()
      : super(FilterOrdersState(
            isLoading: false,
            deliveryType: DeliveryType.novaPost,
            paymentType: PaymentType.fullPayment,
            status: 'New',
            createdAt: '',
            updatedAt: ''));
}
