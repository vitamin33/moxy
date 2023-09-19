import 'package:moxy/data/models/request/create_order_request.dart';

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

  NetworkCity? mapToNetworkCity(City? city) {
    if (city == null) {
      return null;
    }
    return NetworkCity(
      ref: city.ref,
      mainDescription: city.mainDescription,
      deliveryCityRef: city.deliveryCityRef,
      presentName: city.presentName,
    );
  }

  City? mapToCity(NetworkCity? city) {
    if (city == null) {
      return null;
    }
    return City(
      mainDescription: city.mainDescription!,
      ref: city.ref!,
      deliveryCityRef: city.deliveryCityRef!,
      presentName: city.presentName!,
    );
  }
}
