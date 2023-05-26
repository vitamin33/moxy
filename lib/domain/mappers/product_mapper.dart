import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

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
              .map((e) => Dimension(color: e.color, quantity: e.quantity))
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
    Map<int, Dimension> dimenMap = {};
    for (var i = 0; i < success.dimensions.length; i++) {
      dimenMap.putIfAbsent(
          i,
          () => Dimension(
              color: success.dimensions[i].color,
              quantity: success.dimensions[i].quantity));
    }

    return Product(
      name: success.name,
      description: success.description,
      costPrice: success.costPrice,
      salePrice: success.salePrice,
      dimensions: success.dimensions
          .map((e) => Dimension(color: e.color, quantity: e.quantity))
          .toList(),
      idName: success.idName,
      images: success.images
          .map(
            (e) => ImagePath(type: Type.network, imagePath: e),
          )
          .toList(),
    );
  }
}
