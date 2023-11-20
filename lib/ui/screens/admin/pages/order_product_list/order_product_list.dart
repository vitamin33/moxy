import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/models/dimension_product.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/domain/admin/order_product_list/order_product_list_state.dart';
import 'package:moxy/utils/common.dart';
import '../../../../components/search_textfield.dart';
import '../../../../../constant/icon_path.dart';
import '../../../../../domain/models/product.dart';
import '../../../../../domain/admin/order_product_list/order_product_list_cubit.dart';
import '../../../../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderProductList extends StatelessWidget {
  final OrderProductListState state;
  final OrderProductListCubit cubit;
  // ignore: use_key_in_widget_constructors
  const OrderProductList({
    Key? key,
    required this.state,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Scaffold(
      body: Material(
        color: AppTheme.pink,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchTextfield(
                  title: AppLocalizations.of(context)!.search,
                ),
              ),
              Expanded(
                  child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.productsByDimension.length,
                          itemBuilder: (BuildContext context, int index) {
                            final dimenProduct =
                                state.productsByDimension.elementAt(index);
                            bool availableInStock =
                                dimenProduct.isAvailableInStock;
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  if (availableInStock) {
                                    cubit.toggleProductSelection(index);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: dimenProduct.isSelected
                                          ? Colors.black
                                          : Colors.transparent,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: _listTile(
                                      state, dimenProduct, cubit, index, theme),
                                ),
                              ),
                            );
                          },
                        )),
              CustomButton(
                title: AppLocalizations.of(context)!.choose,
                onTap: () {
                  cubit.productsSelected();
                  context.pop();

                  // if (isEditFrom) {
                  //   context
                  //       .read<AdminHomeRouterCubit>()
                  //       .navigateTo(const EditOrderPageState());
                  // } else {
                  //   context.read<AdminHomeRouterCubit>().navigateTo(
                  //         const CreateOrderPageState(),
                  //       );
                  // }
                },
                buttonWidth: MediaQuery.of(context).size.width - 90,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildProductImage(DimensionProduct product) {
  if (product.dimension.images.isNotEmpty) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: product.dimension.images.first.imagePath,
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

Color _generateColor(Dimension dimen) {
  return hexToColor(dimen.color.hexCode);
}

Widget _listTile(OrderProductListState state, DimensionProduct product,
    OrderProductListCubit cubit, int index, AppTheme theme) {
  final Dimension colorAvatar = state.productsByDimension[index].dimension;
  final color = _generateColor(colorAvatar);
  final chosenQuantity = product.selectedQuantity;
  final fullQuantity = product.dimension.quantity;

  final bool isAvailableInStock = product.isAvailableInStock;

  // Define a function to handle the add button tap
  void handleAddButtonTap() {
    if (isAvailableInStock) {
      cubit.quantityAdd(index);
    }
  }

  // Define a function to handle the remove button tap
  void handleRemoveButtonTap() {
    if (isAvailableInStock) {
      cubit.quantityRemove(index);
    }
  }

  return ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.all(18.0),
    tileColor: isAvailableInStock
        ? AppTheme.white
        : AppTheme.greyLigth, // Use grayed out color

    leading: Stack(
      children: [
        ClipOval(
          child: _buildProductImage(product),
        ),
        Positioned(
          top: 22.0,
          left: 25.0,
          child: CircleAvatar(
            radius: 14,
            backgroundColor: AppTheme.white,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: color,
            ),
          ),
        ),
      ],
    ),
    title: Text(product.name),
    subtitle: Text('${product.salePrice} '),
    trailing: product.isSelected
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
                        handleRemoveButtonTap();
                      },
                      icon: const Icon(Icons.remove),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Text(
                    '$chosenQuantity/$fullQuantity',
                    style: theme.smallText,
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
                        handleAddButtonTap();
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
