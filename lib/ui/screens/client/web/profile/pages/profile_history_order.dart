import 'package:flutter/material.dart';

import '../../../../../theme/app_theme.dart';

class ProfileHistoryOrder extends StatelessWidget {
  const ProfileHistoryOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: EdgeInsets.all(AppTheme.cardPadding),
      child: const Text(
        'Історія Замовлення',
        style: TextStyle(
          fontSize: 28,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
