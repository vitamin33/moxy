import 'package:moxy/data/models/request/create_order_request.dart';
import 'package:moxy/domain/models/warehouse.dart';
import '../../data/models/response/nova_network.dart';

class WarehouseMapper {
  List<Warehouse> mapToWarehouseList(List<NovaNetworkWarehouse> networkCities) {
    return networkCities
        .map(
          (e) => Warehouse(
              ref: e.ref,
              postMachineType: e.postMachineType,
              description: e.description,
              number: int.parse(e.number)),
        )
        .toList();
  }

  Warehouse? mapToWarehouse(NetworkNovaPost? network) {
    if (network == null) {
      return null;
    }
    return Warehouse(
      ref: network.ref,
      postMachineType: network.postMachineType,
      description: network.presentName,
      number: network.number,
    );
  }

  NetworkNovaPost? mapToNetworkNovaPost(Warehouse? warehouse) {
    if (warehouse == null) {
      return null;
    }
    return NetworkNovaPost(
      ref: warehouse.ref,
      postMachineType: warehouse.postMachineType,
      presentName: warehouse.description,
      number: warehouse.number,
    );
  }
}
