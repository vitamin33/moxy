import 'package:moxy/domain/edit_order/edit_order_state.dart';
import 'package:moxy/domain/ui_effect.dart';

import '../../constant/order_constants.dart';
import '../../services/cubit_with_effects.dart';
import '../models/city.dart';
import '../models/order.dart';
import '../models/warehouse.dart';
import '../validation_mixin.dart';

class EditOrderCubit extends CubitWithEffects<EditOrderState, UiEffect>
    with ValidationMixin {
  EditOrderCubit()
      : super(EditOrderState(
            isLoading: false,
            isSuccess: false,
            errorMessage: '',
            errors: FieldErrors(),
            deliveryType: DeliveryType.novaPost,
            paymentType: PaymentType.fullPayment,
            selectedProducts: [],
            selectedCity: City.defaultCity(),
            selectedWarehouse: Warehouse.defaultWarehouse(),
            client: Client.defaultClient(),
            status: 'New',
            prepayment: '150'));
}
