import '../../data/models/response/network_city.dart';
import '../models/city.dart';

class CityMapper {
  List<City> mapToCityList(List<NetworkCity> networkCities) {
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
