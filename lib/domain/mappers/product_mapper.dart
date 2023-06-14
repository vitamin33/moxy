import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_orders_response.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/domain/models/order.dart';

import '../models/product.dart';

class ProductMapper {
  List<Product> mapToProductList(List<NetworkProduct> networkProducts) {
    return networkProducts.map(
      (p) {
        Map<int, Dimension> dimenMap = {};
        for (var i = 0; i < p.dimensions.length; i++) {
          dimenMap.putIfAbsent(
              i,
              () => Dimension(
                  color: p.dimensions[i].color,
                  quantity: p.dimensions[i].quantity));
        }
        return Product(
          id: p.id,
          name: p.name,
          description: p.description,
          costPrice: p.costPrice,
          salePrice: p.salePrice,
          dimensions: p.dimensions
              .map((e) => Dimension(
                    color: e.color,
                    quantity: e.quantity,
                    image: _mapColorDimensionImage(e),
                  ))
              .toList(),
          idName: p.idName,
          images: p.images
              .map(
                (e) => ImagePath(type: Type.network, imagePath: e),
              )
              .toList(),
        );
      },
    ).toList();
  }

  String _mapColorDimensionImage(NetworkDimension dimension) {
    switch (dimension.color) {
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
        images: p.images.map((e) => e.imagePath).toList());
  }

  Product mapToProduct(NetworkProduct success) {
    return Product(
      name: success.name,
      description: success.description,
      costPrice: success.costPrice,
      salePrice: success.salePrice,
      dimensions: success.dimensions
          .map((e) => Dimension(
                color: e.color,
                quantity: e.quantity,
                image: _mapColorDimensionImage(e),
              ))
          .toList(),
      idName: success.idName,
      images: success.images
          .map(
            (e) => ImagePath(type: Type.network, imagePath: e),
          )
          .toList(),
    );
  }

  List<OrderedItem> mapToOrderedItemList(
      List<NetworkOrderedItemResponse> networkOrderedItems) {
    return networkOrderedItems.map((p) {
      return OrderedItem(
        productId: p.product,
        productName: p.productName,
        imageUrl: p.imageUrl,
        dimensions: p.dimensions
            .map(
              (e) => Dimension(
                color: e.color,
                quantity: e.quantity,
                image: _mapColorDimensionImage(e),
              ),
            )
            .toList(),
      );
    }).toList();
  }
}
