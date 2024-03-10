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
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/lottie_loader.dart';
import 'package:moxy/ui/screens/components/quantity_picker.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/responsive_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    if (state.isLoading)
                      LottieLoader(
                        size: 40,
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
                const SizedBox(height: 40),
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
          return _buildProductItem(cubit, item, theme, isMobile);
        },
      );
    }
  }
}

Widget _buildProductItem(
    BasketCubit cubit, BasketItem item, AppTheme theme, bool isMobile) {
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
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '$productName $color',
                          maxLines: 3,
                          style: theme.largeBoltText,
                        ),
                      ),
                      Text(
                        '${item.product.salePrice} uah',
                        style: theme.largeBoltText,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Color:', style: theme.largeText),
                      _buildColorWidget(item.dimension),
                    ],
                  ),
                ),
                Row(
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
                      child: const Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(
                            Icons.delete,
                            color: AppTheme.black,
                          )),
                      onTap: () {
                        cubit.removeProductFromBasket(item);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildProductImage(BasketItem item) {
  if (item.dimension.images.isNotEmpty) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: item.dimension.images.first.imagePath,
      width: 100,
      height: 150,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      width: 100,
      height: 150,
      'assets/images/placeholder.jpg',
      fit: BoxFit.cover,
    );
  }
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

Color _generateColor(Dimension dimen) {
  return hexToColor(dimen.color.hexCode);
}
