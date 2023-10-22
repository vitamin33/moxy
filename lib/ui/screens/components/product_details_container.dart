import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/components/custom_button.dart';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if (!state.isLoading)
                    ImageCarousel(dimensions: state.product.dimensions),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.product.name,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.w700),
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
                          style: TextStyle(color: AppTheme.gray),
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
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.pinkDark)),
                            const SizedBox(
                              width: 20,
                            ),
                            Text('${state.product.salePrice} UAH',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: AppTheme.gray,
                                    decoration: TextDecoration.lineThrough)),
                          ],
                        )
                      : Row(children: [
                          Text('${state.product.salePrice} UAH',
                              style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.pinkDark)),
                        ]),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text('Color:'),
                      SizedBox(
                        width: 300,
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
                  Text(state.product.description),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        children: [
                          QuantityPicker(
                            quantity: 1,
                            onPlus: () {},
                            onMinus: () {},
                          ),
                          SizedBox(width: 5),
                          CustomButton(
                            outline: true,
                            title: 'ADD TO CART',
                            onTap: () {},
                            buttonWidth: 275,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        title: 'BUY IT NOW',
                        onTap: () {},
                        buttonWidth: 400,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 400,
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
                                const Text("Розміри:"),
                                Text(
                                    state.product.attributes.widthInCm
                                            .toString() +
                                        'x' +
                                        state.product.attributes.heightInCm
                                            .toString() +
                                        'x' +
                                        state.product.attributes.lengthInCm
                                            .toString())
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Вага:"),
                                Text(state.product.attributes.weightInGrams
                                    .toString())
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Виробник:"),
                                Text(state.product.attributes.producer
                                    .toString())
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Сезонність:"), Text('Зима')],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: AppTheme.black,
                      ),
                      const CustomAccordion(
                        showIcon: false,
                        title: 'РОЗМІРНА СІТКА',
                        content: '',
                      ),
                      const Divider(
                        color: AppTheme.black,
                      ),
                    ]),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

Widget _buildColorWidget(Dimension dimen, ProductDetailsCubit cubit) {
  return GestureDetector(
    onTap: () {
      cubit.setSeletedColor(dimen.color);
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
