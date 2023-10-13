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
          dimenMap.putIfAbsent(i, () => mapToDimension(dimens[i]));
        }
        // return Product(
        //   id: p.id,
        //   name: p.name,
        //   description: p.description ?? '',
        //   costPriceInUsd: p.costPriceInUsd,
        //   weightInGrams: p.weightInGrams,
        //   salePrice: p.salePrice,
        //   dimensions: dimens
        //       .map((e) => Dimension(
        //             color: e.color,
        //             quantity: e.quantity,
        //             image: _mapColorDimensionImage(e.color),
        //           ))
        //       .toList(),
        //   idName: p.idName,
        //   images: p.images
        //       .map(
        //         (e) => ImagePath(type: Type.network, imagePath: e),
        //       )
        //       .toList(),
        //   forSale: p.forSale,
        // );
        return mapToProduct(p);
      },
    ).toList();
  }

  NetworkProduct mapToNetworkProduct(Product p) {
    return NetworkProduct(
      id: p.id,
      name: p.name,
      description: p.description,
      costPriceInUsd: p.costPriceInUsd,
      weightInGrams: p.weightInGrams,
      costPrice: p.costPrice,
      salePrice: p.salePrice,
      dimensions: p.dimensions.map((d) => mapToNetworkDimension(d)).toList(),
      idName: p.idName,
      category: p.category,
      forSale: p.forSale,
      attributes: mapToNetworkAttributes(p.attributes),
    );
  }

  Product mapToProduct(NetworkProduct network) {
    List<NetworkDimension> dimens = network.dimensions ?? [];
    return Product(
      // id: success.id,
      // name: success.name,
      // description: success.description ?? '',
      // costPriceInUsd: success.costPriceInUsd,
      weightInGrams: network.weightInGrams,
      // salePrice: success.salePrice,
      id: network.id,
      name: network.name,
      description: network.description ?? '',
      costPriceInUsd: network.costPriceInUsd,
      discountPrice: network.discountPrice ?? 0,
      costPrice: network.costPrice ?? 0,
      salePrice: network.salePrice,
      dimensions: dimens
          .map(
            (e) => mapToDimension(e),
          )
          .toList(),
      idName: network.idName,
      category: network.category,
      forSale: network.forSale,
      attributes: mapToAttributes(network.attributes),
    );
  }

  Dimension mapToDimension(NetworkDimension network) {
    return Dimension(
      color: mapToColor(network.color),
      size: mapToSize(network.size),
      material: mapToMaterial(network.material),
      quantity: network.quantity,
      images: network.images
          .map(
            (e) => ImagePath(type: Type.network, imagePath: e),
          )
          .toList(),
    );
  }

  ProductAttributes mapToAttributes(NetworkProductAttributes network) {
    return ProductAttributes(
      weightInGrams: network.weightInGrams,
      heightInCm: network.heightInCm,
      widthInCm: network.widthInCm,
      lengthInCm: network.lengthInCm,
      depthInCm: network.depthInCm,
      season: network.season,
      furniture: network.furniture,
      strap: network.strap,
      producer: network.producer,
      style: network.style,
    );
  }

  NetworkProductAttributes mapToNetworkAttributes(ProductAttributes item) {
    return NetworkProductAttributes(
      weightInGrams: item.weightInGrams,
      heightInCm: item.heightInCm,
      widthInCm: item.widthInCm,
      lengthInCm: item.lengthInCm,
      depthInCm: item.depthInCm,
      season: item.season,
      furniture: item.furniture,
      strap: item.strap,
      producer: item.producer,
      style: item.style,
    );
  }

  NetworkDimension mapToNetworkDimension(Dimension dimen) {
    return NetworkDimension(
      color: mapToNetworkColor(dimen.color),
      size: mapToNetworkSize(dimen.size),
      material: mapToNetworkMaterial(dimen.material),
      quantity: dimen.quantity,
      images: dimen.images.map((e) => e.imagePath).toList(),
    );
  }

  NetworkColor mapToNetworkColor(ProductColor item) {
    return NetworkColor(
      id: item.id,
      name: item.name,
      hexCode: item.hexCode,
    );
  }

  NetworkMaterial? mapToNetworkMaterial(ProductMaterial? item) {
    if (item == null) {
      return null;
    }
    return NetworkMaterial(
      id: item.id,
      name: item.name,
    );
  }

  NetworkSize? mapToNetworkSize(ProductSize? item) {
    if (item == null) {
      return null;
    }
    return NetworkSize(
      id: item.id,
      name: item.name,
    );
  }

  ProductColor mapToColor(NetworkColor network) {
    return ProductColor(
      id: network.id,
      name: network.name,
      hexCode: network.hexCode,
    );
  }

  ProductSize? mapToSize(NetworkSize? network) {
    if (network == null) {
      return null;
    }
    return ProductSize(
      id: network.id,
      name: network.name,
    );
  }

  ProductMaterial? mapToMaterial(NetworkMaterial? network) {
    if (network == null) {
      return null;
    }
    return ProductMaterial(
      id: network.id,
      name: network.name,
    );
  }

  List<OrderedItem> mapToOrderedItemList(
      List<NetworkOrderedItemResponse> networkOrderedItems) {
    return networkOrderedItems.map((p) {
      return OrderedItem(
        productPrice: p.productPrice.toString(),
        productId: p.product,
        productName: p.productName ?? '',
        dimensions: p.dimensions.map((e) => mapToDimension(e)).toList(),
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
            material: dimenItem.dimension.material,
            size: dimenItem.dimension.size,
            quantity: dimenItem.selectedQuantity,
            images: dimenItem.dimension.images,
          ),
        );
      } else {
        finalList.add(
          OrderedItem(
            productPrice: dimenItem.salePrice.toString(),
            productId: dimenItem.id,
            productName: dimenItem.name,
            dimensions: [
              Dimension(
                color: dimenItem.dimension.color,
                material: dimenItem.dimension.material,
                size: dimenItem.dimension.size,
                quantity: dimenItem.selectedQuantity,
                images: dimenItem.dimension.images,
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
      final productCostPrice = product.costPriceInUsd;
      final productSalePrice = product.salePrice;
      final productIdName = product.idName;

      for (final dimension in product.dimensions) {
        final color = dimension.color;
        final quantity = dimension.quantity;

        final newDimension = Dimension(
          color: color,
          material: dimension.material,
          size: dimension.size,
          quantity: quantity,
          images: dimension.images,
        );
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

      for (final dimension in item.dimensions) {
        final color = dimension.color;
        final quantity = dimension.quantity;

        final newDimension = Dimension(
          color: color,
          material: dimension.material,
          size: dimension.size,
          quantity: quantity,
          images: dimension.images,
        );

        final newProduct = DimensionProduct(
          id: item.productId,
          name: productName,
          description: '',
          costPrice: 0,
          salePrice: productSalePrice,
          idName: '',
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
