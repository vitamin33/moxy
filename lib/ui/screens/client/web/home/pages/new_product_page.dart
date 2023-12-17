import 'package:flutter/material.dart';

import '../../../../../theme/app_theme.dart';
import '../../../../components/footer_web.dart';
import '../../../../components/new_product_list.dart';
import '../../../../components/promo_container.dart';

class NewProductPage extends StatelessWidget {
  const NewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        child:
            Column(
          children: [
            NewProductList(),
            PromoContainer(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
