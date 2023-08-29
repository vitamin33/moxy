import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/ui/screens/components/onhover.dart';

import '../../../domain/models/product.dart';
import '../../theme/app_theme.dart';

class PromoPage extends StatelessWidget {
  final String backgroundImage;
  final String discountPercentage;
  final String collectionName;
  final Product? product;
  final String? finalDate;
  final int activePage;
  final int allPromoCounth;

  const PromoPage({
    required this.backgroundImage,
    required this.discountPercentage,
    required this.collectionName,
    required this.activePage,
    required this.allPromoCounth,
    this.product,
    this.finalDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
                fit: BoxFit.cover, image: NetworkImage(backgroundImage))),
        child: Stack(children: [
          textPromo(discountPercentage, collectionName, product, finalDate),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                          allPromoCounth,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: () {
                                    // cubit.pageController.animateToPage(index,
                                    //     duration:
                                    //         const Duration(milliseconds: 300),
                                    //     curve: Curves.easeIn);
                                  },
                                  child: CircleAvatar(
                                    radius: 7,
                                    backgroundColor: AppTheme.white,
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: activePage == index
                                          ? AppTheme.white
                                          : Colors.transparent.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  )))
        ]));
  }
}

Widget textPromo(String discountPercentage, String collectionName,
    Product? product, String? finalDate) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: OnHover(builder: ((isHovered) {
          return Container(
            decoration: BoxDecoration(
                color: isHovered ? AppTheme.white : Colors.transparent,
                border: Border.all(color: AppTheme.white),
                borderRadius: BorderRadius.circular(50)),
            height: 50,
            width: 50,
            child: InkWell(
                onTap: () {
                  // cubit.moveToPreviustPage();
                },
                child: Center(
                  child: SvgPicture.asset(
                    IconPath.backArrow,
                    width: 20,
                    color: isHovered
                        ? Colors.transparent.withOpacity(0.9)
                        : AppTheme.white,
                  ),
                )),
          );
        })),
      ),
      Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '-${discountPercentage}%',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 105.60,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 11.62,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  collectionName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 41.99,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 25),
                if (product != null)
                  Text(
                    product.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 41.99,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20)),
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.white)),
                    child: const Text(
                      "Перейти в каталог",
                      style: TextStyle(
                        color: Color(0xFF0C0C0C),
                        fontSize: 19.20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                if (finalDate != null)
                  Column(
                    children: [
                      Text('До кінця акції залишилось'),
                      CountDownText(
                        due: DateTime.parse(finalDate),
                        finishedText: "Done",
                        showLabel: true,
                        longDateName: true,
                        daysTextLong: " Днів ",
                        hoursTextLong: " Годин ",
                        minutesTextLong: " Хвилин ",
                        secondsTextLong: " Секунд ",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: OnHover(builder: ((isHovered) {
          return Container(
            decoration: BoxDecoration(
                color: isHovered ? AppTheme.white : Colors.transparent,
                border: Border.all(color: AppTheme.white),
                borderRadius: BorderRadius.circular(50)),
            height: 50,
            width: 50,
            child: InkWell(
                onTap: () {
                  // cubit.moveToNextPage();
                },
                child: Center(
                  child: SvgPicture.asset(
                    IconPath.forwardArrow,
                    width: 20,
                    color: isHovered
                        ? Colors.transparent.withOpacity(0.9)
                        : AppTheme.white,
                  ),
                )),
          );
        })),
      ),
    ],
  );
}
