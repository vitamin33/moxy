import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/admin/all_products/all_products_cubit.dart';
import 'package:moxy/domain/admin/all_products/all_products_effects.dart';
import 'package:moxy/domain/admin/all_products/all_products_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/admin/admin_home_router_cubit.dart';

import '../../../../components/search_textfield.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isSearchVisible = true;
  late AllProductsCubit cubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    cubit = context.read<AllProductsCubit>();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isSearchVisible = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isSearchVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final AllProductsCubit cubit = context.read<AllProductsCubit>();
    cubit.effectStream.listen((effect) {
      if (effect is ProductsLoadingFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                '${AppLocalizations.of(context)!.productsLoadingFailed} ${effect.failureText}'));
      }
      if (effect is DeleteProductFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                '${AppLocalizations.of(context)!.deleteProductFailed} ${effect.failureText}'));
      }
    });
    return BlocBuilder<AllProductsCubit, AllProductsState>(
      builder: (context, state) {
        return Scaffold(
          body: Material(
            color: AppTheme.pink,
            child: Stack(
              children: [
                _buildLoadingIfNeeded(state),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      cubit.refreshAllProducts();
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          backgroundColor: AppTheme.pink,
                          surfaceTintColor: AppTheme.pink,
                          floating: true,
                          pinned: false,
                          snap: true,
                          toolbarHeight: _isSearchVisible ? 56.0 : 0.0,
                          title: _isSearchVisible
                              ? SearchTextfield(
                                  title: AppLocalizations.of(context)!.search,
                                  onChanged: (term) =>
                                      cubit.searchProducts(term),
                                )
                              : null,
                        ),
                        SliverToBoxAdapter(
                          child: ListView.builder(
                              controller: _scrollController,
                              shrinkWrap: true,
                              itemCount: state.allProducts.length,
                              itemBuilder: (BuildContext context, int index) {
                                final product = state.allProducts[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: GestureDetector(
                                    onLongPressStart:
                                        (LongPressStartDetails details) {
                                      showDeleteContextMenu(
                                          context, product.id, details);
                                    },
                                    child: ListTile(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.all(14.0),
                                      onTap: () {
                                        context
                                            .read<AdminHomeRouterCubit>()
                                            .navigateTo(
                                              CreateProductPageState(
                                                editProductId: product.id,
                                                isEditMode: true,
                                              ),
                                            );
                                      },
                                      tileColor: AppTheme.white,
                                      leading: ClipOval(
                                        child: _buildProductImage(product),
                                      ),
                                      title: Text(product.name),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('${product.salePrice} $uah'),
                                          Text(
                                              '${AppLocalizations.of(context)!.createProductCostPrice}: ${product.costPriceInUsd} $uah')
                                        ],
                                      ),
                                      trailing: SvgPicture.asset(
                                          IconPath.forwardArrow),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showDeleteContextMenu(
      BuildContext context, String? productId, LongPressStartDetails details) {
    if (productId == null) {
      return;
    }
    final offset = details.globalPosition;

    final RelativeRect position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy,
      MediaQuery.of(context).size.width - offset.dx,
      MediaQuery.of(context).size.height - offset.dy,
    );

    showMenu(
        color: AppTheme.pinkDark,
        surfaceTintColor: AppTheme.gray,
        context: context,
        position: position,
        items: [
          PopupMenuItem<String>(
            onTap: () {
              cubit.deleteProduct(productId);
            },
            value: AppLocalizations.of(context)!.delete,
            child: Text(
              AppLocalizations.of(context)!.delete,
              style: const TextStyle(fontSize: 18, color: AppTheme.white),
            ),
          ),
        ]);
  }
}

Widget _buildLoadingIfNeeded(AllProductsState state) {
  return state.isLoading
      ? const LinearProgressIndicator(
          color: AppTheme.pinkDark,
          backgroundColor: AppTheme.pink,
        )
      : Container();
}

Widget _buildProductImage(Product product) {
  if (product.dimensions.first.images.isNotEmpty) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: product.dimensions.first.images.first.imagePath,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      width: 50,
      height: 50,
      'assets/images/placeholder.jpg',
      fit: BoxFit.cover,
    );
  }
}
