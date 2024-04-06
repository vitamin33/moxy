import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/auth/registration/registration_effect.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/domain/models/profile.dart';
import 'package:moxy/domain/validation_mixin.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/rounded_text.dart';
import 'package:moxy/ui/profile_scope.dart';
import 'package:moxy/ui/screens/client/web/checkout/search_city_dropdown.dart';
import 'package:moxy/ui/screens/client/web/checkout/search_warehouse_dropdown.dart';
import 'package:moxy/ui/screens/components/contact_textfield.dart';
import 'package:moxy/ui/screens/components/two_radio_group.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutInfo extends StatefulWidget {
  final CheckoutState state;
  const CheckoutInfo({super.key, required this.state});

  @override
  State<CheckoutInfo> createState() => _CheckoutInfoState();
}

class _CheckoutInfoState extends State<CheckoutInfo> {
  late CheckoutCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = context.read<CheckoutCubit>();
    cubit.effectStream.listen((effect) {
      if (effect is NavigateToLogin) {
        context.push(RouterProvider.loginPath());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final cubit = context.read<CheckoutCubit>();
    final profile = ProfileScope.of(context);

    return Column(
      children: [
        ..._buildUserChoosingWidget(theme, cubit, context, profile),
        ..._buildContactInfoWidget(theme, cubit, context),
        ..._buildDeliveryWidget(theme, cubit, context),
        ..._buildPaymentWidget(theme, cubit, context),
      ],
    );
  }

  List<Widget> _buildUserChoosingWidget(
    AppTheme theme,
    CheckoutCubit cubit,
    BuildContext context,
    Profile? profile,
  ) {
    if (profile == null || !profile.isGuest()) {
      return [];
    }
    return [
      const SizedBox(height: 10),
      Row(
        children: [
          const RoundedText(number: 1),
          const SizedBox(width: 8),
          Text(AppLocalizations.of(context)!.whoAreYou.toUpperCase(),
              style: theme.largeBoltText),
        ],
      ),
      const SizedBox(height: 16),
      TwoRadioGroup(
        selectedIndex: _userSelectedIndex(widget.state),
        firstOption: RadioItem(
          0,
          SvgPicture.asset(IconPath.guestUser, width: 35, height: 35),
          AppLocalizations.of(context)!.userTypeGuest,
          AppLocalizations.of(context)!.userTypeGuestLabel,
        ),
        secondOption: RadioItem(
          1,
          SvgPicture.asset(IconPath.pinkDiamond, width: 35, height: 35),
          AppLocalizations.of(context)!.userTypeRegular,
          AppLocalizations.of(context)!.userTypeRegularLabel,
        ),
        onItemSelected: (value) {
          if (_mapToUserType(value) == UserType.regularCustomer) {
            context.push(RouterProvider.loginPath());
          }
        },
      ),
      const SizedBox(height: 30),
    ];
  }

  List<Widget> _buildContactInfoWidget(
    AppTheme theme,
    CheckoutCubit cubit,
    BuildContext context,
  ) {
    return [
      Row(
        children: [
          const RoundedText(number: 2),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context)!.contactInfo.toUpperCase(),
            style: theme.largeBoltText,
          ),
        ],
      ),
      const SizedBox(height: 30),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 1,
            child: ContactTextField(
                labelText: AppLocalizations.of(context)!.userFirstName,
                controller: cubit.firstNameController,
                onChanged: cubit.firstNameChanged,
                hasError: widget.state.errors.firstName != null),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: ContactTextField(
              labelText: AppLocalizations.of(context)!.userSecondName,
              controller: cubit.secondNameController,
              onChanged: cubit.secondNameChanged,
              hasError: widget.state.errors.secondName != null,
            ),
          ),
        ],
      ),
      const SizedBox(height: 30),
      ContactTextField(
          labelText: AppLocalizations.of(context)!.userPhoneNumber,
          prefixText: '+38',
          controller: cubit.phoneNumberController,
          onChanged: cubit.phoneNumberChanged,
          hasError: widget.state.errors.phoneNumber != null),
      const SizedBox(
        height: 30,
      ),
      SearchCityDropdown(
        selectedCity: widget.state.selectedCity,
        selectedWarehouse: widget.state.selectedWarehouse,
        onChanged: (city) {
          cubit.selectCity(city);
        },
      ),
      const SizedBox(height: 20),
      SearchWarehouseDropdown(
        selectedCity: widget.state.selectedCity,
        selectedWarehouse: widget.state.selectedWarehouse,
        onChanged: (warehouse) {
          cubit.selectWarehouse(warehouse);
        },
      )
    ];
  }

  List<Widget> _buildDeliveryWidget(
    AppTheme theme,
    CheckoutCubit cubit,
    BuildContext context,
  ) {
    return [
      const SizedBox(height: 30),
      Row(
        children: [
          const RoundedText(number: 3),
          const SizedBox(width: 8),
          Text(AppLocalizations.of(context)!.chooseDeliveryType.toUpperCase(),
              style: theme.largeBoltText),
        ],
      ),
      const SizedBox(height: 16),
      TwoRadioGroup(
        selectedIndex: _deliverySelectedIndex(widget.state),
        firstOption: RadioItem(
          0,
          Image.asset(ImageAssets.novaPoshta, width: 60, height: 35),
          AppLocalizations.of(context)!.novaPoshta,
          AppLocalizations.of(context)!.novaPoshtaAdvantage,
        ),
        secondOption: RadioItem(
          1,
          Image.asset(ImageAssets.ukrPoshta, width: 60, height: 35),
          AppLocalizations.of(context)!.ukrPoshta,
          AppLocalizations.of(context)!.ukrPoshtaDisadvantage,
        ),
        onItemSelected: (value) => {
          cubit.changeDelivery(_mapToDeliveryType(value)),
        },
      ),
      const SizedBox(height: 30),
    ];
  }

  List<Widget> _buildPaymentWidget(
    AppTheme theme,
    CheckoutCubit cubit,
    BuildContext context,
  ) {
    return [
      const SizedBox(height: 30),
      Row(
        children: [
          const RoundedText(number: 4),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context)!.choosePaymentType.toUpperCase(),
            style: theme.largeBoltText,
          ),
        ],
      ),
      const SizedBox(height: 16),
      TwoRadioGroup(
        selectedIndex: _paymentSelectedIndex(widget.state),
        firstOption: RadioItem(
          0,
          SvgPicture.asset(IconPath.fullPayment, width: 30),
          AppLocalizations.of(context)!.fullPayment,
          AppLocalizations.of(context)!.fullPaymentAdvantage,
        ),
        secondOption: RadioItem(
          1,
          SvgPicture.asset(IconPath.cashPayment, width: 30),
          AppLocalizations.of(context)!.cashAdvance,
          AppLocalizations.of(context)!.cashAdvanceDisadvantage,
        ),
        onItemSelected: (value) =>
            {cubit.changePayment(_mapToPaymentType(value))},
      ),
      const SizedBox(height: 30),
    ];
  }

  int? _userSelectedIndex(CheckoutState state) {
    if (state.userType == UserType.guest) {
      return 0;
    } else if (state.userType == UserType.regularCustomer) {
      return 1;
    } else {
      return null;
    }
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

  UserType _mapToUserType(RadioItem value) {
    if (value.index == 0) {
      return UserType.guest;
    } else {
      return UserType.regularCustomer;
    }
  }

  String? _validatorForTextField(FieldError? errorField, String errorMessage) {
    if (errorField != null) {
      return errorMessage;
    } else {
      return null;
    }
  }
}
