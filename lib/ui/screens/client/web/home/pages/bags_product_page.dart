import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_cubit.dart';
import 'package:moxy/domain/client/bags_catalog/bags_catalog_state.dart';
import 'package:moxy/ui/screens/components/bags_catalog.dart';

import '../../../../../theme/app_theme.dart';
import '../../../../components/filter_container.dart';
import '../../../../components/footer_web.dart';
import '../../../../components/promo_container.dart';

class BagsProductPage extends StatelessWidget {
  const BagsProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BagsCatalogCubit>(
        create: (context) => BagsCatalogCubit(),
        child: BlocBuilder<BagsCatalogCubit, BagsCatalogState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppTheme.white,
              body: SingleChildScrollView(
                  child: Padding(
                padding:const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    FilterContainer(
                      title: 'Сумки',
                      productCount: state.bagsList.length.toString(),
                    ),
                    const BagsCatalog(),
                    const PromoContainer(),
                    const Footer(),
                  ],
                ),
              )),
            );
          },
        ));
  }
}
