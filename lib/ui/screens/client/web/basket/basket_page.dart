import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/basket/basket_effect.dart';
import 'package:moxy/domain/client/basket/basket_state.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/product_item.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as dartJsFile;

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> with TickerProviderStateMixin {
  late BasketCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = context.read<BasketCubit>();
    cubit.getBasketInfo();
    cubit.effectStream.listen((effect) {
      if (effect is BasketApiRequestFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: effect.failureText));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, state) {
        final theme = AppTheme.of(context)!;

        return Container(
          height: MediaQuery.of(context).size.height,
          color: AppTheme.white,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.basket.toUpperCase(),
                      style: theme.headline4BoltText,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                            context, 'Data returns from left side sheet');
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: AppTheme.greyLigth,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              IconPath.closeDrawer,
                            ),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                (state.isLoading)
                    ? const LinearProgressIndicator()
                    : const SizedBox(
                        height: 4,
                      ),
                const SizedBox(height: 20),
                Expanded(
                    child: _buildBasketItemList(
                        cubit, state.basket, theme, isMobile)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Вартість замовлення',
                    ),
                    Text('${state.basket.totalValue().toString()} $uah'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlineStateButton(
                  title: AppLocalizations.of(context)!.checkout.toUpperCase(),
                  onTap: () {
                    Navigator.pop(
                      context,
                    );

                    dartJsFile.context.callMethod('fbqInitiateCheckoutEvent');

                    context.push(RouterProvider.checkoutPath());
                  },
                  buttonWidth: double.infinity,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBasketItemList(
      BasketCubit cubit, Basket basket, AppTheme theme, bool isMobile) {
    if (basket.isEmpty()) {
      return Column(
        children: [
          SizedBox(
              height: 260,
              width: 200,
              child: Lottie.asset('assets/anim/empty_list.json')),
          const Text(
            'Ваша корзина порожня.\n Не пропустіть шанс зробити свій день яскравішим!',
            textAlign: TextAlign.center,
          ),
        ],
      );
    } else {
      return ListView.builder(
        itemCount: basket.basketItems.length,
        itemBuilder: (context, index) {
          final item = basket.basketItems[index];
          return ProductItem(
              productItem: item,
              addQuantityOfProduct: cubit.addQuantityOfProduct,
              removeQuantityOfProduct: cubit.removeQuantityOfProduct,
              removeProductFromBasket: cubit.removeProductFromBasket);
        },
      );
    }
  }
}
