import 'package:flutter/material.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/screens/components/expandable_text.dart';
import 'package:moxy/ui/screens/components/loading_elevated_button.dart';
import 'package:moxy/ui/screens/components/quantity_picker.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import 'package:provider/provider.dart';

class CheckoutProducts extends StatelessWidget {
  final double productRowHeight = 150;
  final CheckoutState state;
  const CheckoutProducts({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final cubit = context.read<CheckoutCubit>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ..._buildYourOrderWidget(theme, cubit),
          ..._buildCheckoutArea(theme, cubit),
          ..._buildWarningsAndTerms(theme, cubit),
        ],
      ),
    );
  }

  List<Widget> _buildYourOrderWidget(AppTheme theme, CheckoutCubit cubit) {
    List<Widget> productWidgets = [];
    int rowCount = state.basket.basketItems.length;

    for (int i = 0; i < rowCount; i++) {
      productWidgets.add(
        _buildProductItem(cubit, theme, i),
      );
    }
    return [
      Align(
        alignment: Alignment.centerLeft,
        child:
            Text('Your order'.toUpperCase(), style: theme.checkoutHeadingText),
      ),
      const SizedBox(height: 30),
      ...productWidgets,
      const SizedBox(height: 30),
    ];
  }

  List<Widget> _buildCheckoutArea(AppTheme theme, CheckoutCubit cubit) {
    String freeShippingText = state.isFreeShipping
        ? 'You have free shipping.'
        : 'In order to have free shipping you need to order more for ';

    return [
      Divider(
        color: AppTheme.gray.withOpacity(0.3),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total value to pay'.toUpperCase(),
              style: theme.checkoutHeadingText,
            ),
            Text(
              '${state.basket.totalValue()} $uah',
              style: theme.checkoutPriceText,
            )
          ],
        ),
      ),
      Divider(
        color: AppTheme.gray.withOpacity(0.3),
      ),
      const SizedBox(height: 30),
      ExpandableShippingText(
        collapsedText: freeShippingText,
        price: state.isFreeShipping
            ? null
            : '${state.basket.amountForFreeShipping()} $uah',
        additionalText:
            'For free shipping you need to order at least for ${state.basket.freeShippingThreshold} $uah.',
      ),
      const SizedBox(height: 32),
      LoadingElevatedButton(
          onPressed: () {
            cubit.clickCheckout();
          },
          isLoadingState: state.isLoadingPaymentButton),
      const SizedBox(height: 20),
    ];
  }

  List<Widget> _buildWarningsAndTerms(AppTheme theme, CheckoutCubit cubit) {
    return [
      const SizedBox(height: 10),
      Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: 'Ordering on MOXY.UA you agreed with ',
                style: theme.checkoutWarningText),
            TextSpan(
              text: 'Privacy And Policy',
              style: theme.checkoutWarningText.copyWith(
                color: AppTheme.pinkDark,
                fontWeight: FontWeight.w600,
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
              text: 'Warning: ',
              style: theme.checkoutWarningText
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            TextSpan(
                text:
                    'Your order is keeping for 5 days in post warehouse. On 6th day it will be returned back to the sender.',
                style: theme.checkoutWarningText),
          ],
        ),
      ),
    ];
  }

  Widget _buildProductItem(CheckoutCubit cubit, AppTheme theme, int index) {
    BasketItem item = state.basket.basketItems[index];
    String productName = item.product.name.toUpperCase();
    String color = item.dimension.color.name.toUpperCase();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(item),
          const SizedBox(width: 30),
          Expanded(
            child: SizedBox(
              height: productRowHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$productName $color',
                          style: theme.checkoutProductText,
                        ),
                        Text(
                          '${item.product.salePrice} $uah',
                          style: theme.checkoutPriceText,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Color:', style: theme.checkoutColorText),
                        _buildColorWidget(item.dimension),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuantityPicker(
                          quantity: item.dimension.quantity,
                          onPlus: () {
                            cubit.addQuantityOfProduct(item);
                          },
                          onMinus: () {
                            cubit.removeQuantityOfProduct(item);
                          },
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              'Remove',
                              style: theme.removeButtonText,
                            ),
                          ),
                          onTap: () {
                            cubit.removeProductFromBasket(item);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorWidget(Dimension dimen) {
    final color = _generateColor(dimen);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          style: BorderStyle.solid,
          color: AppTheme.gray.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: AppTheme.greyLigth,
        child: CircleAvatar(radius: 13, backgroundColor: color),
      ),
    );
  }

  Widget _buildProductImage(BasketItem item) {
    if (item.dimension.images.isNotEmpty) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: item.dimension.images.first.imagePath,
        width: productRowHeight,
        height: productRowHeight,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        width: productRowHeight,
        height: productRowHeight,
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
      );
    }
  }
}

Color _generateColor(Dimension dimen) {
  return hexToColor(dimen.color.hexCode);
}
