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
            dimensions: dimenMap,
            idName: p.idName,
            images: p.images);
      },
    ).toList();
  }

  NetworkProduct mapToNetworkProduct(
      Product p, Map<int, Dimension> dimensions) {
    return NetworkProduct(
        id: p.id,
        name: p.name,
        description: p.description,
        costPrice: p.costPrice,
        salePrice: p.salePrice,
        dimensions: dimensions.values
            .map((d) => NetworkDimension(color: d.color, quantity: d.quantity))
            .toList(),
        idName: p.idName,
        images: p.images);
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
        dimensions: dimenMap,
        idName: success.idName,
        images: success.images);
  }
}
