import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/ui/screens/components/onhover_text.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppTheme.pink,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      width: double.infinity,
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(padding: const EdgeInsets.all(20.0), child: emailColumn()),
          menuColumn(),
          contactColumn()
        ],
      ),
    );
  }
}

emailColumn() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SvgPicture.asset(IconPath.moxyLogoWeb),
      const SizedBox(height: 40),
      const SizedBox(
        width: 440,
        child: Text(
          'ПІДПИШИСЬ ЩОБ ОТРИМАТИ КАШБЕК -15% ВІД ПЕРШОГО ЗАМОВЛЕННЯ',
          style: TextStyle(
            color: Color(0xFF0C0C0C),
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      const SizedBox(height: 40),
      SizedBox(
          width: 440,
          child: Stack(
            children: [
              TextField(),
              Positioned(
                  top: 20,
                  right: 0,
                  child: GestureDetector(
                      onTap: () {},
                      child: SvgPicture.asset(IconPath.textFieldArrowWeb)))
            ],
          )),
      const SizedBox(height: 40),
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
  );
}

menuColumn() {
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
      OnHoverText(
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
      OnHoverText(
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
      OnHoverText(
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
      OnHoverText(
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
      OnHoverText(
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
      OnHoverText(
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

contactColumn() {
  return const Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
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
      SizedBox(height: 58),
      Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ПІДТРИМКА',
            style: TextStyle(
              color: Color(0xFF0C0C0C),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 22),
          Text(
            'E-mail: Support@moxy.ua',
            style: TextStyle(
              color: Color(0xFF0C0C0C),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    ],
  );
}
