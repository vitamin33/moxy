import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/screens/components/promo_timer.dart';
import 'package:moxy/utils/responsive_utils.dart';

import '../../../domain/models/product.dart';
import '../../theme/app_theme.dart';

class PromoPage extends StatelessWidget {
  final String backgroundImage;
  final String discountPercentage;
  final String collectionName;
  final Product? product;
  final DateTime? finalDate;
  final int activePage;
  final int allPromoCounth;
  final Function() moveToNextPage;
  final Function() moveToPreviusPage;
  final Function(int index) animatedToPage;

  const PromoPage({
    super.key,
    required this.backgroundImage,
    required this.discountPercentage,
    required this.collectionName,
    required this.activePage,
    required this.allPromoCounth,
    this.product,
    this.finalDate,
    required this.moveToNextPage,
    required this.moveToPreviusPage,
    required this.animatedToPage,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return OnHover(
      builder: (isContainerHovered) {
        bool isMobile = ResponsiveUtil.isMobile(context);
        bool hoverActive = isContainerHovered || isMobile;
        return Container(
          height: 350,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(backgroundImage))),
          child: Stack(
            children: [
              textPromo(
                discountPercentage,
                collectionName,
                product,
                finalDate,
                moveToNextPage,
                moveToPreviusPage,
                theme,
                hoverActive,
                isMobile,
              ),
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
                                    animatedToPage(index);
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
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget textPromo(
    String discountPercentage,
    String collectionName,
    Product? product,
    DateTime? finalDate,
    Function moveToNextPage,
    Function moveToPreviustPage,
    AppTheme theme,
    bool isContainerHovered,
    bool isMobile,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: isContainerHovered ? 1 : 0,
          child: _buildPreviousArrow(moveToPreviustPage, isMobile),
        ),
        if (finalDate != null)
          PromoTimer(
            finalDate: finalDate,
          ),
        Opacity(
          opacity: isContainerHovered ? 1 : 0,
          child: _buildNextArrow(moveToNextPage, isMobile),
        ),
      ],
    );
  }

  Widget _buildPreviousArrow(
    Function moveToPreviustPage,
    bool isMobile,
  ) {
    final spacing =
        isMobile ? AppTheme.arrowPaddingMobile : AppTheme.arrowPadding;
    return Padding(
      padding: EdgeInsets.all(spacing),
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
                moveToPreviustPage();
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
    );
  }

  Widget _buildNextArrow(
    Function moveToNextPage,
    bool isMobile,
  ) {
    final spacing = isMobile
        ? AppTheme.defaultGridSpacingMobile
        : AppTheme.defaultGridSpacing;
    return Padding(
      padding: EdgeInsets.all(spacing),
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
                moveToNextPage();
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
    );
  }
}

Widget _buildDiscountInfo(
  AppTheme theme,
  DateTime? finalDate,
  Product? product,
  String collectionName,
  String discountPercentage,
) {
  return Expanded(
    child: Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 70),
        child: Container(
          decoration: const BoxDecoration(
              color: Color.fromARGB(157, 255, 235, 253),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (finalDate != null)
                  PromoTimer(
                    finalDate: finalDate,
                  ),
                const SizedBox(height: 20),
                Text('-$discountPercentage%',
                    style:
                        theme.bigTitleBoltText.copyWith(color: AppTheme.white)),
                const SizedBox(height: 20),
                Text(
                  collectionName,
                  style: theme.headline4SemiBoltText
                      .copyWith(color: AppTheme.white),
                ),
                const SizedBox(height: 20),
                if (product != null)
                  Text(product.name,
                      style:
                          theme.headline2Text.copyWith(color: AppTheme.white)),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20)),
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.white)),
                    child: Text(
                      "Перейти в каталог",
                      style: theme.headlineText,
                    )),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
