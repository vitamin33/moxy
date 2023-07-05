import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/admin/all_products/all_products_cubit.dart';
import 'package:moxy/domain/admin/all_products/all_products_effects.dart';
import 'package:moxy/domain/admin/all_products/all_products_state.dart';
import 'package:moxy/domain/admin/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/services/navigation/admin_home_router_cubit.dart';

import '../../../../components/search_textfield.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../theme/app_theme.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ScrollController _scrollController = ScrollController();
  bool _isSearchVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
                'Products loading failed: ${effect.failureText}'));
      }
    });
    return BlocConsumer<AllProductsCubit, AllProductsState>(
      listener: (context, state) {
        if (state.errorMessage != '') {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWhenFailure(snackBarFailureText: 'Failed'));
          context.read<CreateProductCubit>().clearErrorState();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Material(
            color: AppTheme.pink,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CustomScrollView(slivers: [
                SliverAppBar(
                  backgroundColor: AppTheme.pink,
                  surfaceTintColor: AppTheme.pink,
                  floating: true,
                  pinned: false,
                  snap: true,
                  toolbarHeight: _isSearchVisible ? 56.0 : 0.0,
                  title: _isSearchVisible
                      ? const SearchTextfield(title: 'Search')
                      : null,
                ),
                SliverToBoxAdapter(
                  child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: state.allProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final product = state.allProducts[index];
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.all(14.0),
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
                                  subtitle: Text('${product.salePrice} UAH'),
                                  trailing:
                                      SvgPicture.asset(IconPath.forwardArrow)),
                            );
                          }),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildProductImage(Product product) {
  if (product.images.isNotEmpty) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: product.images.first.imagePath,
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
