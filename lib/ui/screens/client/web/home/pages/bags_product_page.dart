import 'package:flutter/material.dart';

import '../../../../../theme/app_theme.dart';
import '../../../../components/filter_container.dart';
import '../../../../components/footer_web.dart';
import '../../../../components/promo_container.dart';

class BagsProductPage extends StatelessWidget {
  const BagsProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            FilterContainer(title: 'Сумки',productCount: '34',),
            PromoContainer(),
            Footer(),
          ],
        ),
      )),
    );
  }
}
