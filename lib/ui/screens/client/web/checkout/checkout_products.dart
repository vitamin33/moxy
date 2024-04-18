import 'package:flutter/material.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/ui/screens/components/expandable_text.dart';
import 'package:moxy/ui/screens/components/loading_elevated_button.dart';
import 'package:moxy/ui/screens/components/product_item.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/moxy_analytics.dart';
import 'package:moxy/utils/responsive_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CheckoutProducts extends StatelessWidget {
  final double productRowHeight = 150;
  final CheckoutState state;
  const CheckoutProducts({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final cubit = context.read<CheckoutCubit>();
    final isMobile = ResponsiveUtil.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ..._buildYourOrderWidget(theme, cubit, isMobile, context),
        ..._buildCheckoutArea(theme, cubit, context),
        ..._buildWarningsAndTerms(theme, cubit, context),
      ],
    );
  }

  List<Widget> _buildYourOrderWidget(AppTheme theme, CheckoutCubit cubit,
      bool isMobile, BuildContext context) {
    List<Widget> productWidgets = [];
    int rowCount = state.basket.basketItems.length;

    for (int i = 0; i < rowCount; i++) {
      productWidgets.add(ProductItem(
          productItem: state.basket.basketItems[i],
          addQuantityOfProduct: cubit.addQuantityOfProduct,
          removeQuantityOfProduct: cubit.removeQuantityOfProduct,
          removeProductFromBasket: cubit.removeProductFromBasket));
    }
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(AppLocalizations.of(context)!.yourOrder.toUpperCase(),
            style: theme.largeBoltText),
      ),
      const SizedBox(height: 30),
      ...productWidgets,
      const SizedBox(height: 30),
    ];
  }

  List<Widget> _buildCheckoutArea(
      AppTheme theme, CheckoutCubit cubit, BuildContext context) {
    String freeShippingText = state.isFreeShipping
        ? AppLocalizations.of(context)!.youHaveFreeShipping
        : AppLocalizations.of(context)!.toHaveFreeShipping;

    return [
      Divider(
        color: AppTheme.gray.withOpacity(0.3),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.totalValueToPay.toUpperCase(),
                style: theme.largeBoltText,
              ),
            ),
            Text(
              '${state.basket.totalValue()} $uah',
              style: theme.mediumBoltText,
            )
          ],
        ),
      ),
      Divider(
        color: AppTheme.gray.withOpacity(0.3),
      ),
      const SizedBox(height: 30),
      ExpandableShippingText(
        maxLines: 5,
        collapsedText: freeShippingText,
        price: state.isFreeShipping
            ? null
            : '${state.basket.amountForFreeShipping()} $uah',
        additionalText:
            '${AppLocalizations.of(context)!.forFreeShippinYouNeed} ${state.basket.freeShippingThreshold} $uah.',
      ),
      const SizedBox(height: 32),
      LoadingElevatedButton(
          onPressed: () {
            cubit.clickCheckout();
            MoxyAnalytics().purchaseEvent(valuePurchase: [
              state.basket.amountForFreeShipping().toString()
            ]);
          },
          isLoadingState: state.isLoadingPaymentButton),
      const SizedBox(height: 20),
    ];
  }

  List<Widget> _buildWarningsAndTerms(
    AppTheme theme,
    CheckoutCubit cubit,
    BuildContext context,
  ) {
    return [
      const SizedBox(height: 10),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: AppLocalizations.of(context)!.orderingYouAgreed,
                style: theme.smallText),
            TextSpan(
              text: AppLocalizations.of(context)!.privacyAndPolicy,
              style: theme.smallBoltText.copyWith(
                color: AppTheme.pinkDark,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: AppLocalizations.of(context)!.warningWithDots,
                style: theme.smallBoltText),
            TextSpan(
                text: AppLocalizations.of(context)!.yourOrderIsKeeping,
                style: theme.smallText),
          ],
        ),
      ),
    ];
  }
}
