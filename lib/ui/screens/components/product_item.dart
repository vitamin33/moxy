import 'package:flutter/material.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/screens/components/quantity_picker.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import 'package:moxy/utils/responsive_utils.dart';

class ProductItem extends StatelessWidget {
  final BasketItem productItem;
  final Function(BasketItem) addQuantityOfProduct;
  final Function(BasketItem) removeQuantityOfProduct;
  final Function(BasketItem) removeProductFromBasket;

  const ProductItem(
      {super.key,
      required this.productItem,
      required this.addQuantityOfProduct,
      required this.removeQuantityOfProduct,
      required this.removeProductFromBasket});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final isMobile = ResponsiveUtil.isMobile(context);
    String color = productItem.dimension.color.name.toUpperCase();
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(flex: 1, child: _buildProductImage(productItem)),
          Expanded(
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            '${productItem.product.name} $color',
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: theme.mediumBoltText,
                          ),
                        ),
                        if (!isMobile)
                          Text(
                            '${productItem.product.salePrice} $uah',
                            style: theme.largeBoltText,
                          ),
                      ],
                    ),
                  ),
                  if (isMobile)
                    Text(
                      '${productItem.product.salePrice} $uah',
                      style: theme.largeBoltText,
                    ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.color,
                            style: theme.largeText),
                        _buildColorWidget(productItem.dimension),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: QuantityPicker(
                          quantity: productItem.dimension.quantity,
                          onPlus: () {
                            addQuantityOfProduct(productItem);
                          },
                          onMinus: () {
                            removeQuantityOfProduct(productItem);
                          },
                        ),
                      ),
                      InkWell(
                        child: const Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.delete)),
                        onTap: () {
                          removeProductFromBasket(productItem);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildProductImage(BasketItem item) {
  if (item.dimension.images.isNotEmpty) {
    return
        FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: item.dimension.images.first.imagePath,
      height: 150,
    );
  } else {
    return Image.asset(
      height: 150,
      'assets/images/placeholder.jpg',
    );
  }
}

Widget _buildColorWidget(Dimension dimen) {
  final color = _generateColor(dimen);
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        style: BorderStyle.solid,
        color: AppTheme.gray.withOpacity(0.4),
        width: 1,
      ),
    ),
    child: CircleAvatar(
      radius: 15,
      backgroundColor: AppTheme.greyLigth,
      child: CircleAvatar(radius: 13, backgroundColor: color),
    ),
  );
}

Color _generateColor(Dimension dimen) {
  return hexToColor(dimen.color.hexCode);
}
