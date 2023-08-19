import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/promo/promo_cubit.dart';
import 'package:moxy/ui/screens/components/onhover.dart';

import '../../../constant/image_path.dart';
import '../../../domain/client/promo/promo_state.dart';
import '../../theme/app_theme.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromoCubit, PromoState>(
      builder: (context, state) {
        final cubit = context.read<PromoCubit>();
        return Container(
            width: double.infinity,
            height: 500,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      ImageAssets.promoBackground,
                    ))),
            child: Stack(children: [
              textPromo(cubit),
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
                              2,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: InkWell(
                                      onTap: () {
                                        cubit.pageController.animateToPage(
                                            index,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      child: CircleAvatar(
                                        radius: 7,
                                        backgroundColor: AppTheme.white,
                                        child: CircleAvatar(
                                          radius: 5,
                                          backgroundColor:
                                              state.activePage == index
                                                  ? AppTheme.white
                                                  : Colors.transparent
                                                      .withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      )))
            ]));
      },
    );
  }
}

Widget textPromo(PromoCubit cubit) {
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
                  cubit.moveToPreviustPage();
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
                const Text(
                  '-50%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 105.60,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 11.62,
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Знижка на колекцію',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 41.99,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'COZY STYLE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 41.99,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
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
                  ),
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
                  cubit.moveToNextPage();
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
