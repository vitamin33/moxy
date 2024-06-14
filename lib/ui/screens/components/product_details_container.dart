import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/basket/basket_effect.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/screens/components/custom_accordion.dart';
import 'package:moxy/ui/screens/components/image_carousel.dart';
import 'package:moxy/ui/screens/components/quantity_picker.dart';
import 'package:moxy/ui/screens/components/rate_indicator.dart';
import 'package:moxy/ui/screens/components/shimmer/shimmer_product_attributes.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/utils/responsive_utils.dart';

class ProductDetailsContainer extends StatefulWidget {
  const ProductDetailsContainer({super.key});

  @override
  State<ProductDetailsContainer> createState() =>
      _ProductDetailsContainerState();
}

class _ProductDetailsContainerState extends State<ProductDetailsContainer> {
  late BasketCubit basketCubit;
  late ProductDetailsCubit productDetailsCubit;

  @override
  void initState() {
    super.initState();
    productDetailsCubit = context.read<ProductDetailsCubit>();
    basketCubit = context.read<BasketCubit>();
    basketCubit.effectStream.listen((effect) {
      if (effect is NavigateToCheckout) {
        context.push(RouterProvider.checkoutPath());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final cubit = context.read<ProductDetailsCubit>();
        final isMobile = ResponsiveUtil.isMobile(context);

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 0.0,
            horizontal: isMobile ? 0 : 0,
          ),
          child: isMobile
              ? Column(
                  children: [
                    const ImageCarousel(),
                    _AboutProductDetails(state: state, cubit: cubit)
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 4,
                      child: ImageCarousel(),
                    ),
                    Expanded(
                      flex: 5,
                      child: _AboutProductDetails(state: state, cubit: cubit),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _AboutProductDetails extends StatelessWidget {
  final ProductDetailsState state;
  final ProductDetailsCubit cubit;

  const _AboutProductDetails({
    required this.state,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isLoading) {
      return const ShimmerProductDetails();
    }

    final theme = AppTheme.of(context)!;
    final cubit = context.read<ProductDetailsCubit>();
    final isMobile = ResponsiveUtil.isMobile(context);
    final basketCubit = context.read<BasketCubit>();
    final rightPanelWidth = MediaQuery.of(context).size.width * 0.4;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            state.productDetails.product.name.toUpperCase(),
            style: theme.headline4BoltText,
          ),
          isMobile
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _PriceView(state: state),
                    const _RatingView(),
                  ],
                )
              : Column(
                  children: [
                    const _RatingView(),
                    const SizedBox(height: 20),
                    _PriceView(state: state),
                  ],
                ),
          const Divider(
            color: AppTheme.gray,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.color,
                style: theme.headlineSemiBoltText,
              ),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 50,
                  minHeight: 50,
                  maxWidth: rightPanelWidth,
                  minWidth: 100,
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var dimen in state.productDetails.product.dimensions)
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: _ColorSelector(dimension: dimen, cubit: cubit),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (isMobile)
            // Padding(
            //   padding: EdgeInsets.all(8),
            //   child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Quantity',
                style: theme.headlineSemiBoltText,
              ),
              SizedBox(height: 10),
              Container(
                width: 100,
                child: QuantityPicker(
                  quantity: state.productDetails.selectedDimension.quantity,
                  onPlus: () {
                    cubit.addQuantityOfProduct();
                  },
                  onMinus: () {
                    cubit.removeQuantityOfProduct();
                  },
                ),
              ),
            ]),
          // ),
          SizedBox(height: 10),
          _ButtonsArea(state: state, basketCubit: basketCubit),
          _AttributesInfo(state: state),
        ],
      ),
    );
  }
}

class _AttributesInfo extends StatelessWidget {
  final ProductDetailsState state;
  const _AttributesInfo({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Column(
      children: [
        const Divider(
          color: AppTheme.black,
        ),
        CustomAccordion(
          title: 'ПРО ПРОДУКТ',
          content: state.productDetails.product.description,
          showIcon: false,
        ),
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
                  Text(
                    "Розміри:",
                    style: theme.mediumText,
                  ),
                  Text(
                    state.productDetails.product.attributes.sizeString,
                    style: theme.mediumText,
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Вага:",
                    style: theme.mediumText,
                  ),
                  Text(
                      state.productDetails.product.attributes.weightInGrams
                          .toString(),
                      style: theme.mediumText)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Виробник:",
                    style: theme.mediumText,
                  ),
                  Text(
                      state.productDetails.product.attributes.producer
                          .toString(),
                      style: theme.mediumText)
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Сезонність:",
                    style: theme.mediumText,
                  ),
                  Text(
                    'Зима',
                    style: theme.mediumText,
                  )
                ],
              ),
            ],
          ),
        ),
        const Divider(
          color: AppTheme.black,
        ),
        const CustomAccordion(
          title: 'БЕЗКОШТОВНА ДОСТАВКА ВІД 1800 ГРН',
          content:
              'Безкоштовна доставка при замовленні від 1800 грн. В разі обміну або повернення, усіх товарів або частини товарів із цього замовлення, безкоштовна доставка анулюється.',
          showIcon: false,
        ),
        const Divider(
          color: AppTheme.black,
        ),
        const CustomAccordion(
          title: '30 ДНІВ НА ПОВЕРНЕННЯ',
          content:
              'Товар підлягає поверненню протягом 30 днів з моменту отримання замовлення.Як виглядає весь процес? Все просто!Ви відправляєте товар по зворотній адресі.Ми повертаємо кошти наступного дня після надходження товару на наш склад..',
          showIcon: false,
        ),
        const Divider(
          color: AppTheme.black,
        ),
        const CustomAccordion(
          title: 'ЛЕГКЕ ПОВЕРНЕННЯ ЗА 0 ГРИВЕНЬ',
          content:
              'Скористуйся послугою легке повернення від Нової Пошти.Деталі за посиланням',
          showIcon: false,
        ),
        const Divider(
          color: AppTheme.black,
        ),
      ],
    );
  }
}

class _ButtonsArea extends StatelessWidget {
  final ProductDetailsState state;
  final BasketCubit basketCubit;
  const _ButtonsArea({required this.state, required this.basketCubit});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    final cubit = context.read<ProductDetailsCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!isMobile)
          Row(
            children: [
              QuantityPicker(
                quantity: state.productDetails.selectedDimension.quantity,
                onPlus: () {
                  cubit.addQuantityOfProduct();
                },
                onMinus: () {
                  cubit.removeQuantityOfProduct();
                },
              ),
              const SizedBox(width: 5),
              Expanded(
                flex: 7,
                child: OutlineStateButton(
                  outline: true,
                  title: 'ADD TO CART',
                  onTap: () {
                    context.read<BasketCubit>().addProductDetailsToBasket(
                        productDetails: state.productDetails);
                  },
                  buttonWidth: isMobile ? 450 : 375,
                ),
              ),
            ],
          ),
        if (isMobile)
          OutlineStateButton(
            outline: true,
            title: 'ADD TO CART',
            onTap: () {
              context.read<BasketCubit>().addProductDetailsToBasket(
                  productDetails: state.productDetails);
            },
            buttonWidth: isMobile ? 450 : 375,
          ),
        const SizedBox(height: 10),
        OutlineStateButton(
          title: 'BUY IT NOW',
          onTap: () {
            basketCubit.addProductDetailsToBasket(
              productDetails: state.productDetails,
              navigateToCheckout: true,
            );
          },
          buttonWidth: isMobile ? 450 : 500,
        ),
      ],
    );
  }
}

class _PriceView extends StatelessWidget {
  final ProductDetailsState state;
  const _PriceView({required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final isMobile = ResponsiveUtil.isMobile(context);
    return state.productDetails.product.discountPrice != 0
        ? isMobile
            ? Column(
                children: [
                  Text('${state.productDetails.product.salePrice} UAH',
                      style: theme.largeText.copyWith(
                          color: AppTheme.gray,
                          decoration: TextDecoration.lineThrough)),
                  const SizedBox(width: 10),
                  Text('${state.productDetails.product.discountPrice} UAH',
                      style: theme.headline3BoltText
                          .copyWith(color: AppTheme.pinkDark)),
                ],
              )
            : Row(
                children: [
                  Text('${state.productDetails.product.discountPrice} UAH',
                      style: theme.headline3BoltText
                          .copyWith(color: AppTheme.pinkDark)),
                  const SizedBox(
                    width: 20,
                  ),
                  Text('${state.productDetails.product.salePrice} UAH',
                      style: theme.titleText.copyWith(
                          color: AppTheme.gray,
                          decoration: TextDecoration.lineThrough)),
                ],
              )
        : Row(
            children: [
              Text('${state.productDetails.product.salePrice} UAH',
                  style: theme.headline3BoltText
                      .copyWith(color: AppTheme.pinkDark)),
            ],
          );
  }
}

class _RatingView extends StatelessWidget {
  const _RatingView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final theme = AppTheme.of(context)!;
        final isMobile = ResponsiveUtil.isMobile(context);

        return isMobile
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(state.reviewStats.avgRating),
                      ),
                      RatingBarIndicator(
                        rating: double.parse(state.reviewStats.avgRating),
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${state.reviewStats.totalVotes} відгуків',
                      style: theme.mediumText.copyWith(
                        color: AppTheme.gray,
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(state.reviewStats.avgRating),
                  ),
                  RatingBarIndicator(
                    rating: double.parse(state.reviewStats.avgRating),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      '${state.reviewStats.totalVotes} відгуків',
                      style: theme.mediumText.copyWith(
                        color: AppTheme.gray,
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}

class _ColorSelector extends StatelessWidget {
  final Dimension dimension;
  final ProductDetailsCubit cubit;

  const _ColorSelector({
    required this.dimension,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => cubit.setSeletedColor(dimension),
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            style: BorderStyle.solid,
            color: dimension.isSelected
                ? AppTheme.red
                : AppTheme.gray.withOpacity(0.4),
            width: 1,
          ),
        ),
        child: CircleAvatar(
          radius: 15,
          backgroundColor: AppTheme.greyLigth,
          child: CircleAvatar(
            radius: 13,
            backgroundColor: hexToColor(dimension.color.hexCode),
          ),
        ),
      ),
    );
  }
}
