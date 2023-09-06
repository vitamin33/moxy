import 'package:flutter/material.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/screens/components/quantity_picker.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';

class CheckoutProducts extends StatelessWidget {
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
    return [
      Text('Total value to pay'.toUpperCase(),
          style: theme.checkoutHeadingText),
      const SizedBox(height: 30),
      const Text('You need to free shepping'),
      const SizedBox(height: 16),
      ElevatedButton(onPressed: () {}, child: const Text('Checkout')),
      const SizedBox(height: 20),
    ];
  }

  List<Widget> _buildWarningsAndTerms(AppTheme theme, CheckoutCubit cubit) {
    return [
      const SizedBox(height: 10),
      const Text('Warning Warning Warning'),
      const SizedBox(height: 10),
      const Text('Warning Warning Warning')
    ];
  }

  Widget _buildProductItem(CheckoutCubit cubit, AppTheme theme, int index) {
    BasketItem item = state.basket.basketItems[index];
    String productName = item.product.name.toUpperCase();
    String color = item.dimension.color.toUpperCase();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProductImage(item),
        const SizedBox(width: 20),
        Expanded(
          child: SizedBox(
            height: 180,
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
                        '$productName $color}',
                        style: theme.checkoutProductText,
                      ),
                      Text(
                        '${item.product.salePrice} UAH',
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
                      Text('${item.product.salePrice} UAH'),
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
                          padding: EdgeInsets.all(8),
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
    );
  }

  Widget _buildColorWidget(Dimension dimen) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          style: BorderStyle.solid,
          color: Colors.transparent,
          width: 1,
        ),
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: AppTheme.white,
        child: CircleAvatar(
          radius: 15,
          backgroundColor: AppTheme.pink,
          backgroundImage: AssetImage(dimen.image!),
        ),
      ),
    );
  }

  Widget _buildProductImage(BasketItem item) {
    if (item.product.images.isNotEmpty) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: item.product.images.first.imagePath,
        width: 180,
        height: 180,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        width: 180,
        height: 180,
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
      );
    }
  }
}
