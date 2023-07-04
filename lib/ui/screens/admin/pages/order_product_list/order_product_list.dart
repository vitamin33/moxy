import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/services/navigation/admin_home_router_cubit.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/constant/product_colors.dart';
import 'package:moxy/domain/admin/order_product_list/order_product_list_state.dart';
import '../../../../components/search_textfield.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../../constant/icon_path.dart';
import '../../../../../domain/admin/create_product/create_product_cubit.dart';
import '../../../../../domain/models/product.dart';
import '../../../../../domain/admin/order_product_list/order_product_list_cubit.dart';
import '../../../../theme/app_theme.dart';

class OrderProductList extends StatelessWidget {
  const OrderProductList({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderProductListCubit>(
        create: (BuildContext context) => OrderProductListCubit(
              OrderProductListState.defaultAllProductsState(),
            ),
        child: BlocConsumer<OrderProductListCubit, OrderProductListState>(
          listener: (context, state) {
            if (state.errorMessage != '') {
              ScaffoldMessenger.of(context).showSnackBar(
                  snackBarWhenFailure(snackBarFailureText: 'Failed'));
              context.read<CreateProductCubit>().clearErrorState();
            }
          },
          builder: (context, state) {
            final cubit = context.read<OrderProductListCubit>();
            return Scaffold(
              body: Material(
                color: AppTheme.pink,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SearchTextfield(
                          title: 'Search',
                        ),
                      ),
                      Expanded(
                          child: state.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.productsByColor.keys.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final color = state.productsByColor.keys
                                        .elementAt(index);
                                    final Dimension colorAvatar =
                                        allColorsDimens.firstWhere((e) =>
                                            e.color ==
                                            state.productsByColor[color]?.first
                                                .dimensions.first.color);
                                    final products =
                                        state.productsByColor[color]!;
                                    final isSelected =
                                        cubit.isProductSelected(products.first);
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: InkWell(
                                        onTap: () {
                                          cubit.toggleProductSelection(
                                              products.first);
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: isSelected
                                                    ? Colors.black
                                                    : Colors.transparent,
                                                width: 2.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: _listTile(
                                                state,
                                                products,
                                                color,
                                                isSelected,
                                                cubit,
                                                index,
                                                colorAvatar)),
                                      ),
                                    );
                                  },
                                )),
                      CustomButton(
                        title: 'Choose',
                        onTap: () {
                          final isEditFrom = (context
                                  .read<AdminHomeRouterCubit>()
                                  .state as OrderProductListPageState)
                              .isFromEdit;
                          cubit.productsSelected();

                          if (isEditFrom) {
                            context
                                .read<AdminHomeRouterCubit>()
                                .navigateTo(const EditOrderPageState());
                          } else {
                            context.read<AdminHomeRouterCubit>().navigateTo(
                                  const CreateOrderPageState(),
                                );
                          }
                        },
                        buttonWidth: MediaQuery.of(context).size.width - 90,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ));
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
      'assets/images/placeholder.jpg',
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }
}

String _generateImagePath(Dimension dimen) {
  if (dimen.image != null) {
    return dimen.image!;
  } else {
    return 'assets/images/logo.png';
  }
}

Widget _listTile(state, products, color, isSelected,
    OrderProductListCubit cubit, index, colorAvatar) {
  final colorAvatarImage = _generateImagePath(colorAvatar);
  return ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.all(18.0),
    tileColor: AppTheme.white,
    leading: Stack(
      children: [
        ClipOval(
          child: _buildProductImage(products.first),
        ),
        Positioned(
          top: 22.0,
          left: 25.0,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: AppTheme.white,
            child: CircleAvatar(
              radius: 10,
              backgroundImage: AssetImage(colorAvatarImage),
            ),
          ),
        ),
      ],
    ),
    title: Text('${products.first.name}'),
    subtitle: Text('${products.first.salePrice} '),
    trailing: isSelected
        ? SizedBox(
            width: 110,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onLongPress: () {},
                    child: IconButton(
                      constraints: const BoxConstraints(maxHeight: 30),
                      iconSize: 15,
                      color: AppTheme.black,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.white),
                      ),
                      onPressed: () {
                        cubit.quantityRemove(index);
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '${products.first.dimensions.first.quantity}/$color',
                    style: const TextStyle(fontSize: 13),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onLongPress: () {},
                    child: IconButton(
                      constraints: const BoxConstraints(maxHeight: 30),
                      iconSize: 15,
                      color: AppTheme.black,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppTheme.white),
                      ),
                      onPressed: () {
                        cubit.quantityAdd(index);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SvgPicture.asset(IconPath.forwardArrow),
  );
}
