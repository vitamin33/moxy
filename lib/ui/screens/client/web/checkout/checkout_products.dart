import 'package:flutter/material.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/domain/models/basket.dart';
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
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
        _buildProductItem(i),
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

  Widget _buildProductItem(int index) {
    BasketItem item = state.basket.basketItems[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildProductImage(item),
        const SizedBox(width: 20),
        const Text('Orders'),
      ],
    );
  }

  Widget _buildProductImage(BasketItem item) {
    if (item.product.images.isNotEmpty) {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: item.product.images.first.imagePath,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        width: 50,
        height: 50,
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
      );
    }
  }
}
