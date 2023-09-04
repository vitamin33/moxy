import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/ui/components/custom_textfield.dart';

import '../../../constant/icon_path.dart';
import '../../../domain/client/footer/footer_cubit.dart';
import '../../../domain/client/footer/footer_state.dart';
import '../../theme/app_theme.dart';
import 'onhover.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => FooterCubit(),
      child: BlocBuilder<FooterCubit, FooterState>(
        builder: (context, state) {
          final cubit = context.read<FooterCubit>();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(
                  color: AppTheme.pink,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              width: double.infinity,
              height: 400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  emailColumn(cubit, state),
                  menuColumn(),
                  contactColumn()
                ],
              ),
            ),
            // ),
          );
        },
      ),
    );
  }
}

Widget emailColumn(FooterCubit cubit, FooterState state) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        SvgPicture.asset(IconPath.moxyLogoWeb),
        const SizedBox(height: 40),
        const SizedBox(
          width: 290,
          child: Text(
            "ПІДПИШИСЬ ЩОБ ОТРИМАТИ КАШБЕК \n -15% ВІД ПЕРШОГО ЗАМОВЛЕННЯ",
            overflow: TextOverflow.visible,
            maxLines: 5,
            softWrap: true,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
            width: 300,
            child: Stack(
              children: [
                TextField(
                  controller: cubit.userEmailController,
                  maxLines: 1,
                  onChanged: cubit.emailChanged,
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: isValid(state.errors.emailUser)
                                  ? AppTheme.pinkDark
                                  : AppTheme.red))),
                ),
                Positioned(
                    top: 20,
                    right: 0,
                    child: GestureDetector(
                        onTap: () {
                          cubit.sendEmail();
                        },
                        child: SvgPicture.asset(IconPath.textFieldArrowWeb)))
              ],
            )),
        const SizedBox(height: 20),
        Row(
          children: [
            GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      IconPath.instagramIcon,
                      color: AppTheme.white,
                    ),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: AppTheme.black,
                      borderRadius: BorderRadius.circular(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      IconPath.tikTokIcon,
                      color: AppTheme.white,
                    ),
                  ),
                )),
          ],
        ),
      ],
    ),
  );
}

Widget menuColumn() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'МЕНЮ',
        style: TextStyle(
          color: Color(0xFF0C0C0C),
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text(
            'Доставка і оплата',
            style: TextStyle(
              decoration:
                  isHovered ? TextDecoration.underline : TextDecoration.none,
              color: isHovered ? AppTheme.gray : AppTheme.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text(
            'Обмін та повернення ',
            style: TextStyle(
              decoration:
                  isHovered ? TextDecoration.underline : TextDecoration.none,
              color: isHovered ? AppTheme.gray : AppTheme.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text(
            'Як обрати розмір?',
            style: TextStyle(
              decoration:
                  isHovered ? TextDecoration.underline : TextDecoration.none,
              color: isHovered ? AppTheme.gray : AppTheme.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text(
            'Як отримати кешбек?',
            style: TextStyle(
              decoration:
                  isHovered ? TextDecoration.underline : TextDecoration.none,
              color: isHovered ? AppTheme.gray : AppTheme.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text(
            'Запитання',
            style: TextStyle(
              decoration:
                  isHovered ? TextDecoration.underline : TextDecoration.none,
              color: isHovered ? AppTheme.gray : AppTheme.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
      const SizedBox(height: 22),
      OnHover(
        builder: ((isHovered) {
          return Text(
            'Політика конфеденційності',
            style: TextStyle(
              decoration:
                  isHovered ? TextDecoration.underline : TextDecoration.none,
              color: isHovered ? AppTheme.gray : AppTheme.black,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          );
        }),
      ),
    ],
  );
}

Widget contactColumn() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ГРАФІК РОБОТИ',
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 22),
            Text(
              'Понеділок - п’ятниця з 9:00 до 21:00',
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 22),
            Text(
              'Субота - п’ятниця з 10:00 до 19:00',
              style: TextStyle(
                color: Color(0xFF0C0C0C),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 58),
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ПІДТРИМКА',
            style: TextStyle(
              color: Color(0xFF0C0C0C),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              const Text(
                'E-mail: ',
                style: TextStyle(
                  color: Color(0xFF0C0C0C),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
              OnHover(
                builder: ((isHovered) {
                  return Text(
                    'Support@moxy.ua',
                    style: TextStyle(
                        color: isHovered ? AppTheme.gray : AppTheme.black,
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        decoration: isHovered
                            ? TextDecoration.underline
                            : TextDecoration.none),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
