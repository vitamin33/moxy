import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/ui/components/rounded_text.dart';
import 'package:moxy/ui/screens/client/web/checkout/search_city_dropdown.dart';
import 'package:moxy/ui/screens/client/web/checkout/search_warehouse_dropdown.dart';
import 'package:moxy/ui/screens/components/contact_textfield.dart';
import 'package:moxy/ui/screens/components/two_radio_group.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';

class CheckoutInfo extends StatelessWidget {
  final CheckoutState state;
  const CheckoutInfo({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final cubit = context.read<CheckoutCubit>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ..._buildContactInfoWidget(theme, cubit),
          ..._buildDeliveryWidget(theme, cubit),
          ..._buildPaymentWidget(theme, cubit),
        ],
      ),
    );
  }

  List<Widget> _buildContactInfoWidget(AppTheme theme, CheckoutCubit cubit) {
    return [
      Row(
        children: [
          const RoundedText(number: 1),
          const SizedBox(width: 8),
          Text("Contact information".toUpperCase(),
              style: theme.checkoutHeadingText),
        ],
      ),
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: ContactTextField(
              labelText: 'First Name',
              controller: cubit.firstNameController,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: ContactTextField(
              labelText: 'Second Name',
              controller: cubit.secondNameController,
            ),
          ),
        ],
      ),
      const SizedBox(height: 30),
      ContactTextField(
        labelText: 'Phone Number',
        prefixText: '+38',
        controller: cubit.phoneNumberController,
      ),
      const SizedBox(
        height: 30,
      ),
      SearchCityDropdown(
        selectedCity: state.selectedCity,
        selectedWarehouse: state.selectedWarehouse,
        onChanged: (city) {
          cubit.selectCity(city);
        },
      ),
      const SizedBox(height: 20),
      SearchWarehouseDropdown(
        selectedCity: state.selectedCity,
        selectedWarehouse: state.selectedWarehouse,
        onChanged: (warehouse) {
          cubit.selectWarehouse(warehouse);
        },
      )
    ];
  }

  List<Widget> _buildDeliveryWidget(AppTheme theme, CheckoutCubit cubit) {
    return [
      const SizedBox(height: 30),
      Row(
        children: [
          const RoundedText(number: 2),
          const SizedBox(width: 8),
          Text("Choose delivery type".toUpperCase(),
              style: theme.checkoutHeadingText),
        ],
      ),
      const SizedBox(height: 16),
      TwoRadioGroup(
        selectedIndex: _deliverySelectedIndex(state),
        firstOption: RadioItem(
          0,
          Image.asset(ImageAssets.novaPoshta, width: 60, height: 35),
          'Nova Poshta',
          'Fast delivery',
        ),
        secondOption: RadioItem(
          1,
          Image.asset(ImageAssets.ukrPoshta, width: 60, height: 35),
          'Ukr Poshta',
          'Long to wait delivery',
        ),
        onItemSelected: (value) => {
          cubit.changeDelivery(_mapToDeliveryType(value)),
        },
      ),
      const SizedBox(height: 30),
    ];
  }

  List<Widget> _buildPaymentWidget(AppTheme theme, CheckoutCubit cubit) {
    return [
      const SizedBox(height: 30),
      Row(
        children: [
          const RoundedText(number: 3),
          const SizedBox(width: 8),
          Text("Choose payment type".toUpperCase(),
              style: theme.checkoutHeadingText),
        ],
      ),
      const SizedBox(height: 16),
      TwoRadioGroup(
        selectedIndex: _paymentSelectedIndex(state),
        firstOption: RadioItem(
          0,
          SvgPicture.asset(IconPath.fullPayment, width: 30),
          'Full payment',
          'No additional payment',
        ),
        secondOption: RadioItem(
          1,
          SvgPicture.asset(IconPath.cashPayment, width: 30),
          'Cash in advance',
          'You need to pay cash shipping fee',
        ),
        onItemSelected: (value) =>
            {cubit.changePayment(_mapToPaymentType(value))},
      ),
      const SizedBox(height: 30),
    ];
  }

  int? _deliverySelectedIndex(CheckoutState state) {
    if (state.deliveryType == DeliveryType.novaPost) {
      return 0;
    } else if (state.deliveryType == DeliveryType.ukrPost) {
      return 1;
    } else {
      return null;
    }
  }

  int? _paymentSelectedIndex(CheckoutState state) {
    if (state.paymentType == PaymentType.fullPayment) {
      return 0;
    } else if (state.paymentType == PaymentType.cashAdvance) {
      return 1;
    } else {
      return null;
    }
  }

  DeliveryType _mapToDeliveryType(RadioItem value) {
    if (value.index == 0) {
      return DeliveryType.novaPost;
    } else {
      return DeliveryType.ukrPost;
    }
  }

  PaymentType _mapToPaymentType(RadioItem value) {
    if (value.index == 0) {
      return PaymentType.fullPayment;
    } else {
      return PaymentType.cashAdvance;
    }
  }
}
