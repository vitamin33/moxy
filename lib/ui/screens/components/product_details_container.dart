import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/web/client_home_router_cubit.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/moxy_loader.dart';
import 'package:moxy/ui/screens/components/custom_accordion.dart';
import 'package:moxy/ui/screens/components/image_carousel.dart';
import 'package:moxy/ui/screens/components/quantity_picker.dart';
import 'package:moxy/ui/screens/components/rate_indicator.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';

class ProductDetailsContainer extends StatelessWidget {
  ProductDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final cubit = context.read<ProductDetailsCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: state.isLoading
              ? MoxyLoader(
                  iconSize: 50,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageCarousel(dimensions: state.product.dimensions),
                    _aboutProductDetails(state, cubit, context)
                  ],
                ),
        );
      },
    );
  }
}

Widget _aboutProductDetails(ProductDetailsState state,
    ProductDetailsCubit cubit, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.product.name.toUpperCase(),
          style: const TextStyle(
              fontFamily: 'HelveticaNeue',
              fontSize: 36,
              fontWeight: FontWeight.w600),
        ),
        Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text('4.6'),
            ),
            RatingBarIndicator(
              rating: 4.6,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 15.0,
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                '5,890 rating',
                style: TextStyle(
                  color: AppTheme.gray,
                  fontFamily: 'HelveticaNeue',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        state.product.discountPrice != 0
            ? Row(
                children: [
                  Text('${state.product.discountPrice} UAH',
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.w600,
                          color: AppTheme.pinkDark)),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('${state.product.salePrice} UAH',
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: 'HelveticaNeue',
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray,
                          decoration: TextDecoration.lineThrough)),
                ],
              )
            : Row(children: [
                Text('${state.product.salePrice} UAH',
                    style: const TextStyle(
                        fontSize: 30,
                        fontFamily: 'HelveticaNeue',
                        fontWeight: FontWeight.w600,
                        color: AppTheme.pinkDark)),
              ]),
        const SizedBox(height: 20),
        Row(
          children: [
            const Text(
              'Color:',
              style: TextStyle(
                  fontFamily: 'HelveticaNeue',
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 400,
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (Dimension dimen in state.product.dimensions)
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: _buildColorWidget(dimen, cubit),
                    ),
                ],
              ),
            ),
          ],
        ),
        Text(
          state.product.description,
          style: TextStyle(
              fontFamily: 'HelveticaNeue',
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Row(
              children: [
                QuantityPicker(
                  quantity: state.basketItem.dimension.quantity,
                  onPlus: () {
                    cubit.addQuantityOfProduct();
                  },
                  onMinus: () {
                    cubit.removeQuantityOfProduct();
                  },
                ),
                SizedBox(width: 5),
                CustomButton(
                  outline: true,
                  title: 'ADD TO CART',
                  onTap: () {
                    context.read<BasketCubit>().addBasketItemToBasket(state.basketItem);
                  },
                  buttonWidth: 375,
                ),
              ],
            ),
            const SizedBox(height: 10),
            CustomButton(
              title: 'BUY IT NOW',
              onTap: () {
                Navigator.pop(
                  context,
                );
                context.read<BasketCubit>().addBasketItemToBasket(state.basketItem);
                context
                    .read<ClientHomeRouterCubit>()
                    .navigateTo(const CheckoutRoute());
              },
              buttonWidth: 500,
            ),
          ],
        ),
        SizedBox(
          width: 500,
          child: Column(children: [
            const Divider(
              color: AppTheme.black,
            ),
            CustomAccordion(
              showIcon: false,
              title: 'ХАРАКТЕРИСТИКА',
              contentChild: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Розміри:",
                        style: TextStyle(
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                      Text(
                        state.product.attributes.widthInCm.toString() +
                            'x' +
                            state.product.attributes.heightInCm.toString() +
                            'x' +
                            state.product.attributes.lengthInCm.toString(),
                        style: TextStyle(fontFamily: 'HelveticaNeue'),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Вага:",
                        style: TextStyle(fontFamily: 'HelveticaNeue'),
                      ),
                      Text(state.product.attributes.weightInGrams.toString(),
                          style: TextStyle(fontFamily: 'HelveticaNeue'))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Виробник:",
                        style: TextStyle(fontFamily: 'HelveticaNeue'),
                      ),
                      Text(state.product.attributes.producer.toString(),
                          style: TextStyle(fontFamily: 'HelveticaNeue'))
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Сезонність:",
                        style: TextStyle(fontFamily: 'HelveticaNeue'),
                      ),
                      Text(
                        'Зима',
                        style: TextStyle(fontFamily: 'HelveticaNeue'),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Divider(
              color: AppTheme.black,
            ),
            CustomAccordion(
              title: 'БЕЗКОШТОВНА ДОСТАВКА ВІД 1800 ГРН',
              content:
                  'Безкоштовна доставка при замовленні від 1800 грн. В разі обміну або повернення, усіх товарів або частини товарів із цього замовлення, безкоштовна доставка анулюється.',
              showIcon: false,
            ),
            const Divider(
              color: AppTheme.black,
            ),
            CustomAccordion(
              title: '30 ДНІВ НА ПОВЕРНЕННЯ',
              content:
                  'Товар підлягає поверненню протягом 30 днів з моменту отримання замовлення.Як виглядає весь процес? Все просто!Ви відправляєте товар по зворотній адресі.Ми повертаємо кошти наступного дня після надходження товару на наш склад..',
              showIcon: false,
            ),
            const Divider(
              color: AppTheme.black,
            ),
            CustomAccordion(
              title: 'ЛЕГКЕ ПОВЕРНЕННЯ ЗА 0 ГРИВЕНЬ',
              content:
                  'Скористуйся послугою легке повернення від Нової Пошти.Деталі за посиланням',
              showIcon: false,
            ),
            const Divider(
              color: AppTheme.black,
            ),
          ]),
        ),
      ],
    ),
  );
}

Widget _buildColorWidget(Dimension dimen, ProductDetailsCubit cubit) {
  return GestureDetector(
    onTap: () {
      cubit.setSeletedColor(dimen);
    },
    child: Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          style: BorderStyle.solid,
          color:
              dimen.isSelected ? AppTheme.red : AppTheme.gray.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: CircleAvatar(
        radius: 15,
        backgroundColor: AppTheme.greyLigth,
        child: CircleAvatar(
          radius: 13,
          backgroundColor: hexToColor(dimen.color.hexCode),
        ),
      ),
    ),
  );
}
