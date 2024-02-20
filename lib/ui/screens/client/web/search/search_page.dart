import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:moxy/domain/client/search/search_cubit.dart';
import 'package:moxy/domain/client/search/search_effect.dart';
import 'package:moxy/domain/client/search/search_state.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/lottie_loader.dart';
import 'package:moxy/ui/screens/components/product_card.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = SearchCubit();

    cubit.effectStream.listen((effect) {
      if (effect is SearchApiRequestFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: effect.failureText));
      }
      if (effect is SearchValidationFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Wrong input, please check fields.'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    bool isMobile = ResponsiveUtil.isMobile(context);
    final crossAxisCount = isMobile ? 1 : 3;
    final spacing = isMobile
        ? AppTheme.defaultGridSpacingMobile
        : AppTheme.defaultGridSpacing;

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();
          return Scaffold(
              backgroundColor: AppTheme.white,
              body: state.isLoading
                  ? Center(child: LottieLoader())
                  : Padding(
                      padding: const EdgeInsets.all(AppTheme.defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.cardPadding,
                            ),
                            child: Text(
                              'Search',
                              style: theme.bigTitleBoltText,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppTheme.cardPadding),
                            child: TextField(
                              decoration: const InputDecoration(
                                  label: Text('Search Product'),
                                  border: OutlineInputBorder()),
                              onChanged: (value) {
                                cubit.searchProduct(value);
                              },
                            ),
                          ),
                          state.searchProduct.isNotEmpty
                              ? Expanded(
                                  child: AlignedGridView.count(
                                      itemCount: state.searchProduct.length,
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: spacing,
                                      mainAxisSpacing: spacing,
                                      itemBuilder: (context, index) {
                                        return ProductCard(
                                          product: state.searchProduct[index],
                                          onChangeFavorites:
                                              cubit.toggleFavoriteForProduct,
                                        );
                                      }),
                                )
                              : Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: 260,
                                          width: 200,
                                          child: Lottie.asset(
                                              'assets/anim/empty_list.json')),
                                      Text(
                                        'Не знайдено продуктів',
                                        style: theme.largeSemiBoltText,
                                      )
                                    ],
                                  ),
                                )
                        ],
                      ),
                    ));
        },
      ),
    );
  }
}
