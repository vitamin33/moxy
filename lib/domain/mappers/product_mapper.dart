import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';

import '../models/product.dart';

class ProductMapper {
  List<Product> mapToProductList(List<NetworkProduct> networkProducts) {
    return networkProducts
        .map((p) => Product(
            id: p.id,
            name: p.name,
            description: p.description,
            costPrice: p.costPrice,
            salePrice: p.salePrice,
            dimensions: p.dimensions
                .map((d) => Dimension(color: d.color, quantity: d.quantity))
                .toList(),
            idName: p.idName,
            images: p.images))
        .toList();
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
        images: p.images);
  }
}
