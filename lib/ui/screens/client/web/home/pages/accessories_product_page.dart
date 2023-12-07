import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_cubit.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_state.dart';
import 'package:moxy/ui/screens/components/accessories_catalog.dart';

import '../../../../../theme/app_theme.dart';
import '../../../../components/filter_container.dart';
import '../../../../components/footer_web.dart';
import '../../../../components/promo_container.dart';

class AccessoriesProductPage extends StatelessWidget {
  const AccessoriesProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.white,
        body: BlocProvider(
          create: (context) => AccessoriesCatalogCubit(),
          child: BlocBuilder<AccessoriesCatalogCubit, AccessoriesCatalogState>(
            builder: (context, state) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    FilterContainer(
                      title: 'Аксесуари',
                      productCount: state.accessoriesList.length.toString(),
                    ),
                    const AccessoriesCatalog(),
                    const PromoContainer(),
                    const Footer(),
                  ],
                ),
              ));
            },
          ),
        ));
  }
}
