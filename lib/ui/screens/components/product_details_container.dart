import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/constant/product_colors.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/screens/components/custom_accordion.dart';
import 'package:moxy/ui/screens/components/image_carousel.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductDetailsContainer extends StatelessWidget {
  ProductDetailsContainer({super.key});

  final List<String> images = [
    ImageAssets.bigPictureHome,
    ImageAssets.bigPictureHome,
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  ImageCarousel(images: images),
                  const SizedBox(
                    width: 400,
                    child: Column(children: [
                      SizedBox(height: 10),
                      CustomAccordion(
                        title: 'Безкоштовна доставка від 1800 грн',
                        content:
                            'Безкоштовна доставка при замовленні від 1800 грн. В разі обміну або повернення, усіх товарів або частини товарів із цього замовлення, безкоштовна доставка анулюється.',
                        boxShadow: true,
                      ),
                      SizedBox(height: 10),
                      CustomAccordion(
                          title: '30 днів на повернення',
                          content:
                              'Товар підлягає поверненню протягом 30 днів з моменту отримання замовлення.Як виглядає весь процес? Все просто!Ви відправляєте товар по зворотній адресі.Ми повертаємо кошти наступного дня після надходження товару на наш склад..',
                          boxShadow: true),
                      SizedBox(height: 10),
                      CustomAccordion(
                          title: 'Легке повернення за 0 грн',
                          content:
                              'Скористуйся послугою легке повернення від Нової Пошти.Деталі за посиланням',
                          boxShadow: true),
                      SizedBox(height: 10),
                    ]),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Сумка літня рожева ',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('785 uah',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 20),
                  const Text('Color:'),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (Dimension dimen in allColorsDimens)
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: _buildColorWidget(dimen.image!),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text('Відправка завтра 27.09',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  CustomButton(
                    title: 'Купити',
                    onTap: () {},
                    buttonWidth: 300,
                  ),
                  const SizedBox(
                    width: 400,
                    child: Column(children: [
                      Divider(),
                      CustomAccordion(
                        showIcon: false,
                        title: 'Харкатеристика',
                        contentChild: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Код товару"), Text('099769')],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Колір:"),
                                Text('Білий, Колір засмаги')
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Матеріал:"),
                                Text('Екошкіра, Штучне хутро')
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [Text("Сезонність:"), Text('Зима')],
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      CustomAccordion(
                        showIcon: false,
                        title: 'Розмірна сітка',
                        content: '',
                      ),
                      Divider(),
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

Widget _buildColorWidget(String color) {
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
      child: CircleAvatar(
        radius: 13,
        backgroundColor: AppTheme.pink,
        backgroundImage: AssetImage(color),
      ),
    ),
  );
}
