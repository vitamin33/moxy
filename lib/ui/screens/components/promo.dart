import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../constant/image_path.dart';

class Promo extends StatelessWidget {
  const Promo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                ImageAssets.promoBackground,
              ))),
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
                       const EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
                    backgroundColor: MaterialStateProperty.all(AppTheme.white)),
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
    );
  }
}
