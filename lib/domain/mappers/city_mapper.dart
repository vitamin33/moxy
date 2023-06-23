import '../../data/models/response/nova_network.dart';
import '../models/city.dart';

class CityMapper {
  List<City> mapToCityList(List<NovaNetworkCity> networkCities) {
    return networkCities
        .map(
          (e) => City(
            mainDescription: e.mainDescription,
            ref: e.ref,
            deliveryCityRef: e.deliveryCityRef,
            presentName: e.presentName,
          ),
        )
        .toList();
  }
}
