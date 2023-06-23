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
}
