import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/data/models/response/profile_response.dart';
import 'package:moxy/domain/mappers/city_mapper.dart';
import 'package:moxy/domain/mappers/order_mapper.dart';
import 'package:moxy/domain/mappers/product_mapper.dart';
import 'package:moxy/domain/mappers/warehouse_mapper.dart';
import 'package:moxy/domain/models/city.dart';
import 'package:moxy/domain/models/warehouse.dart';

import '../../services/get_it.dart';
import '../models/profile.dart';

class ProfileMapper {
  final productMapper = locate<ProductMapper>();
  final orderMapper = locate<OrderMapper>();
  final cityMapper = locate<CityMapper>();
  final warehouseMapper = locate<WarehouseMapper>();

  Profile mapToProfile(NetworkProfile networkProfile) {
    return Profile(
      favoriteProducts:
          productMapper.mapToProductList(networkProfile.favoriteProducts),
      id: networkProfile.id,
      firstName: networkProfile.firstName,
      secondName: networkProfile.secondName,
      mobileNumber: networkProfile.mobileNumber,
      instagram: networkProfile.instagram ?? '',
      city: cityMapper.mapToCity(networkProfile.city) ?? City.defaultCity(),
      warehouse: warehouseMapper.mapToWarehouse(networkProfile.novaPost) ??
          Warehouse.defaultWarehouse(),
    );
  }

  NetworkProfile mapToNetworkProfile(Profile profile) {
    return NetworkProfile(
        favoriteProducts: profile.favoriteProducts
            // .map((e) => NetworkProduct(
            //     name: e.name,
            //     description: e.description,
            //     costPriceInUsd: e.costPriceInUsd,
            //     weightInGrams: e.weightInGrams,
            //     salePrice: e.salePrice,
            //     dimensions: e.dimensions
            //         .map((e) =>
            //             NetworkDimension(color: e.color, quantity: e.quantity))
            //         .toList(),
            //     idName: e.idName,
            //     images: e.images.map((e) => e.toString()).toList(),
            //     forSale: e.forSale))
// =======
            .map((e) => productMapper.mapToNetworkProduct(e))
// >>>>>>> main
            .toList(),
        firstName: profile.firstName,
        secondName: profile.secondName,
        mobileNumber: profile.mobileNumber,
        instagram: profile.instagram,
        city: cityMapper.mapToNetworkCity(profile.city),
        novaPost: warehouseMapper.mapToNetworkNovaPost(profile.warehouse),
        role: '',
        password: '',
        id: '');
  }
}
