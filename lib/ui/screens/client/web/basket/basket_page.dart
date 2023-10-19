import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/basket/basket_effect.dart';
import 'package:moxy/domain/client/basket/basket_state.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/web/client_home_router_cubit.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/moxy_loader.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/quantity_picker.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    context.read<BasketCubit>().getBasketInfo();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, state) {
        final BasketCubit cubit = context.read<BasketCubit>();
        final theme = AppTheme.of(context)!;
        cubit.effectStream.listen((effect) {
          if (effect is BasketApiRequestFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                snackBarWhenFailure(snackBarFailureText: effect.failureText));
          }
        });
        return Container(
          height: MediaQuery.of(context).size.height,
          color: AppTheme.white,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'BASKET',
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                    ),
                    if (state.isLoading)
                      const MoxyLoader(
                        iconSize: 30,
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
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: _buildBasketItemList(cubit, state.basket, theme),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Вартість замовлення',
                    ),
                    Text('${state.basket.totalValue().toString()} грн'),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  title: 'Chekout',
                  onTap: () {
                    Navigator.pop(
                      context,
                    );
                    context
                        .read<ClientHomeRouterCubit>()
                        .navigateTo(const CheckoutRoute());
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
      BasketCubit cubit, Basket basket, AppTheme theme) {
    if (basket.isEmpty()) {
      return Column(
        children: [
          Lottie.asset(
            'assets/anim/main.json',
            width: 200,
            height: 200,
            fit: BoxFit.fill,
            controller: _controller,
            onLoaded: (composition) {
              // Configure the AnimationController with the duration of the
              // Lottie file and start the animation.
              _controller
                ..duration = composition.duration
                ..forward();
            },
          ),
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
          return _buildProductItem(cubit, item, theme);
        },
      );
    }
  }
}

Widget _buildProductItem(
  BasketCubit cubit,
  BasketItem item,
  AppTheme theme,
) {
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
                        '${item.product.salePrice} uah',
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
