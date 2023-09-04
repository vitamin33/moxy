import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProfileAdress extends StatelessWidget {
  const ProfileAdress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding:const EdgeInsets.all(AppTheme.cardPadding),
      child: const Text(
        'Адресна Книга',
        style: TextStyle(
          fontSize: 28,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
