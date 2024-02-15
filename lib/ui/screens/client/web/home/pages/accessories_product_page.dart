import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_cubit.dart';
import 'package:moxy/domain/client/accessories_catalog/accessories_catalog_state.dart';
import 'package:moxy/ui/screens/components/accessories_catalog.dart';
import 'package:moxy/ui/screens/components/filter_container.dart';

import '../../../../../theme/app_theme.dart';
import '../../../../components/footer.dart';
import '../../../../components/promo_container.dart';

class AccessoriesProductPage extends StatefulWidget {
  const AccessoriesProductPage({super.key});

  @override
  State<AccessoriesProductPage> createState() => _AccessoriesProductPageState();
}

class _AccessoriesProductPageState extends State<AccessoriesProductPage> {
  late final AccessoriesCatalogCubit cubit;
  @override
  void initState() {
    super.initState();
    cubit = AccessoriesCatalogCubit();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.white,
        body: BlocProvider(
          create: (context) => AccessoriesCatalogCubit(),
          child: BlocBuilder<AccessoriesCatalogCubit, AccessoriesCatalogState>(
            builder: (context, state) {
              // final cubit = context.read<AccessoriesCatalogCubit>();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    FilterContainer(
                      title: 'Аксесуари',
                      productCount: state.accessoriesList.length.toString(),
                      parentCubit: cubit,
                    ),
                    const AccessoriesCatalog(),
                    const PromoContainer(),
                    const Footer(),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
