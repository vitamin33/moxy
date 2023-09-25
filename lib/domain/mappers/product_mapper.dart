import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_orders_response.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/domain/models/dimension_product.dart';
import 'package:moxy/domain/models/order.dart';

import '../models/product.dart';

class ProductMapper {
  List<Product> mapToProductList(List<NetworkProduct> networkProducts) {
    return networkProducts.map(
      (p) {
        Map<int, Dimension> dimenMap = {};
        List<NetworkDimension> dimens = p.dimensions ?? [];
        for (var i = 0; i < dimens.length; i++) {
          dimenMap.putIfAbsent(
              i,
              () => Dimension(
                  color: dimens[i].color, quantity: dimens[i].quantity));
        }
        return Product(
          id: p.id,
          name: p.name,
          description: p.description ?? '',
          costPrice: p.costPrice,
          salePrice: p.salePrice,
          dimensions: dimens
              .map((e) => Dimension(
                    color: e.color,
                    quantity: e.quantity,
                    image: _mapColorDimensionImage(e.color),
                  ))
              .toList(),
          idName: p.idName,
          images: p.images
              .map(
                (e) => ImagePath(type: Type.network, imagePath: e),
              )
              .toList(),
          forSale: p.forSale,
        );
      },
    ).toList();
  }

  String _mapColorDimensionImage(String color) {
    switch (color) {
      case 'Black':
        return 'assets/images/black_background.png';
      case 'White':
        return 'assets/images/white_background.png';
      case 'Grey':
        return 'assets/images/grey_background.png';
      case 'Pink':
        return 'assets/images/pink_background.png';
      case 'PinkLeo':
        return 'assets/images/pinkLeo_background.png';
      case 'Leo':
        return 'assets/images/leo_background.png';
      case 'Brown':
        return 'assets/images/brown_background.png';
      case 'Beige':
        return 'assets/images/beige_background.png';
      case 'Purple':
        return 'assets/images/purple_background.png';
      case 'Zebra':
        return 'assets/images/zebra_background.png';
      case 'Jeans':
        return 'assets/images/jeans_background.png';
      case 'Green':
        return 'assets/images/green_background.png';
      case 'Bars':
        return 'assets/images/bars_background.png';
      case 'Unified':
        return 'assets/images/unified_background.png';
    }
    return 'assets/images/black_background.png';
  }

  NetworkProduct mapToNetworkProduct(Product p, List<Dimension> dimensions) {
    return NetworkProduct(
      id: p.id,
      name: p.name,
      description: p.description,
      costPrice: p.costPrice,
      salePrice: p.salePrice,
      dimensions: dimensions
          .map((d) => NetworkDimension(color: d.color, quantity: d.quantity))
          .toList(),
      idName: p.idName,
      images: p.images.map((e) => e.imagePath).toList(),
      forSale: p.forSale,
    );
  }

  Product mapToProduct(NetworkProduct success) {
    List<NetworkDimension> dimens = success.dimensions ?? [];
    return Product(
      id: success.id,
      name: success.name,
      description: success.description ?? '',
      costPrice: success.costPrice,
      salePrice: success.salePrice,
      dimensions: dimens
          .map(
            (e) => Dimension(
              color: e.color,
              quantity: e.quantity,
              image: _mapColorDimensionImage(e.color),
            ),
          )
          .toList(),
      idName: success.idName,
      images: success.images
          .map(
            (e) => ImagePath(type: Type.network, imagePath: e),
          )
          .toList(),
      forSale: success.forSale,
    );
  }

  Dimension mapToDimension(NetworkDimension network) {
    return Dimension(
      color: network.color,
      quantity: network.quantity,
      image: _mapColorDimensionImage(network.color),
    );
  }

  NetworkDimension mapToNetworkDimension(Dimension dimen) {
    return NetworkDimension(
      color: dimen.color,
      quantity: dimen.quantity,
    );
  }

  List<OrderedItem> mapToOrderedItemList(
      List<NetworkOrderedItemResponse> networkOrderedItems) {
    return networkOrderedItems.map((p) {
      return OrderedItem(
        productPrice: p.productPrice.toString(),
        productId: p.product,
        productName: p.productName ?? '',
        imageUrl: p.imageUrl,
        dimensions: p.dimensions
            .map(
              (e) => Dimension(
                color: e.color,
                quantity: e.quantity,
                image: _mapColorDimensionImage(e.color),
              ),
            )
            .toList(),
      );
    }).toList();
  }

  List<OrderedItem> mapProductListToOrderedItemList(
      List<DimensionProduct> productItems) {
    List<OrderedItem> finalList = [];

    for (int i = 0; i < productItems.length; i++) {
      DimensionProduct dimenItem = productItems[i];
      if (!dimenItem.isSelected) {
        continue;
      }
      if (finalList.any((element) => element.productId == dimenItem.id)) {
        OrderedItem item = finalList.firstWhere(
          (element) => element.productId == dimenItem.id,
        );
        item.dimensions.add(
          Dimension(
            color: dimenItem.dimension.color,
            quantity: dimenItem.selectedQuantity,
            image: _mapColorDimensionImage(dimenItem.dimension.color),
          ),
        );
      } else {
        finalList.add(
          OrderedItem(
            productPrice: dimenItem.salePrice.toString(),
            productId: dimenItem.id,
            productName: dimenItem.name,
            imageUrl: dimenItem.image?.imagePath,
            dimensions: [
              Dimension(
                color: dimenItem.dimension.color,
                quantity: dimenItem.selectedQuantity,
                image: dimenItem.dimension.image,
              ),
            ],
          ),
        );
      }
    }

    return finalList;
  }

  List<DimensionProduct> mapToGroupProductsByDimension(
      List<Product> allProducts, List<OrderedItem> selectedItems) {
    final productsByDimension = <DimensionProduct>[];

    for (final product in allProducts) {
      final productName = product.name;
      final productDescription = product.description;
      final productCostPrice = product.costPrice;
      final productSalePrice = product.salePrice;
      final productIdName = product.idName;
      List<ImagePath> productImages = product.images;
      ImagePath? path = productImages.isNotEmpty ? productImages.first : null;

      for (final dimension in product.dimensions) {
        final color = dimension.color;
        final quantity = dimension.quantity;

        final newDimension =
            Dimension(color: color, quantity: quantity, image: dimension.image);
        int selectedQuantity = 1;
        bool isSelected = selectedItems.any((element) {
          bool isDimenSelected =
              element.dimensions.any((d) => d.color == color);
          return element.productId == product.id && isDimenSelected;
        });
        if (isSelected) {
          final selectedItem = selectedItems
              .firstWhere((element) => element.productId == product.id);

          final selectedDimension = selectedItem.dimensions
              .firstWhere((element) => element.color == color);
          selectedQuantity = selectedDimension.quantity;
        }
        final newProduct = DimensionProduct(
          id: product.id,
          name: productName,
          description: productDescription,
          costPrice: productCostPrice,
          salePrice: productSalePrice,
          idName: productIdName,
          image: path,
          dimension: newDimension,
          selectedQuantity: selectedQuantity,
          isSelected: isSelected,
        );

        productsByDimension.add(newProduct);
      }
    }

    return productsByDimension;
  }

  List<DimensionProduct> mapToProductDimensionList(List<OrderedItem> items) {
    final productsByDimension = <DimensionProduct>[];

    for (final item in items) {
      final productName = item.productName;
      final productSalePrice = double.parse(item.productPrice);
      ImagePath? path;
      if (item.imageUrl != null) {
        path = ImagePath(imagePath: item.imageUrl!, type: Type.network);
      }

      for (final dimension in item.dimensions) {
        final color = dimension.color;
        final quantity = dimension.quantity;

        final newDimension =
            Dimension(color: color, quantity: quantity, image: dimension.image);

        final newProduct = DimensionProduct(
          id: item.productId,
          name: productName,
          description: '',
          costPrice: 0,
          salePrice: productSalePrice,
          idName: '',
          image: path,
          dimension: newDimension,
          selectedQuantity: 1,
          isSelected: true,
        );

        productsByDimension.add(newProduct);
      }
    }
    return productsByDimension;
  }
}
