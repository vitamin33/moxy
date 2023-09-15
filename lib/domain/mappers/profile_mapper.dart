import 'package:moxy/data/models/request/create_order_request.dart';
import 'package:moxy/data/models/request/create_product_request.dart';
import 'package:moxy/data/models/response/all_orders_response.dart';
import 'package:moxy/data/models/response/all_products_response.dart';
import 'package:moxy/data/models/response/profile_response.dart';
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
  final warehouseMapper = locate<WarehouseMapper>();

  Profile mapToProfile(NetworkProfile networkProfile) {
    return Profile(
        favoriteProducts:
            productMapper.mapToProductList(networkProfile.favoriteProducts),
            id: networkProfile.id,
        firstName: networkProfile.firstName,
        secondName: networkProfile.secondName,
        mobileNumber: networkProfile.mobileNumber,
        instagram: networkProfile.instagram,
        orders: orderMapper.mapToOrderList(networkProfile.orders),
        city: City(
            mainDescription: networkProfile.city.mainDescription ?? '',
            ref: networkProfile.city.ref ?? '',
            deliveryCityRef: networkProfile.city.deliveryCityRef ?? '',
            presentName: networkProfile.city.presentName ?? ''),
        warehouse: Warehouse(
            description: networkProfile.novaPost.presentName,
            ref: networkProfile.novaPost.ref,
            postMachineType: networkProfile.novaPost.postMachineType ?? '',
            number: networkProfile.novaPost.number));
  }

  NetworkProfile mapToNetworkProfile(Profile profile) {
    return NetworkProfile(
        favoriteProducts: profile.favoriteProducts
            .map((e) => NetworkProduct(
                name: e.name,
                description: e.description,
                costPrice: e.costPrice,
                salePrice: e.salePrice,
                dimensions: e.dimensions
                    .map((e) =>
                        NetworkDimension(color: e.color, quantity: e.quantity))
                    .toList(),
                idName: e.idName,
                images: e.images.map((e) => e.toString()).toList(),
                forSale: e.forSale))
            .toList(),
        firstName: profile.firstName,
        secondName: profile.secondName,
        mobileNumber: profile.mobileNumber,
        instagram: profile.instagram,
        orders: profile.orders
            .map((e) => NetworkOrder(
                id: e.id ?? '',
                cashAdvanceValue: e.cashAdvanceValue,
                novaPost: e.novaPost,
                city: NetworkCity(
                    deliveryCityRef: e.city.deliveryCityRef,
                    ref: e.city.ref,
                    presentName: e.city.presentName,
                    mainDescription: e.city.mainDescription),
                deliveryType: e.deliveryType.name,
                status: e.status.statusTitle,
                paymentType: e.paymentType.name,
                // client: CreateNetworkClient(
                //     e.client.id,
                //     e.client.city,
                //     e.client.firstName,
                //     e.client.mobileNumber,
                //     e.client.secondName,
                //     []),
                // orderedItems: e.orderedItems
                //     .map((e) => NetworkOrderedItemResponse(
                //         e.productId ?? '',
                //         e.productName,
                //         e.dimensions
                //             .map((d) => NetworkDimension(
                //                 color: d.color, quantity: d.quantity))
                //             .toList(),
                //         e.imageUrl,
                //         int.parse(e.productPrice)))
                //     .toList(),
                
                createdAt: e.createdAt,
                updatedAt: e.updatedAt))
            .toList(),
        city: NetworkCity(
            ref: profile.city.ref,
            mainDescription: profile.city.mainDescription,
            deliveryCityRef: profile.city.deliveryCityRef,
            presentName: profile.city.presentName),
        novaPost: NetworkNovaPost(
            ref: profile.warehouse.ref,
            presentName: profile.warehouse.description,
            number: profile.warehouse.number),
        role: '',
        password: '',
        id: '');
  }
}
