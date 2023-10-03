import 'package:moxy/data/models/response/attributes_response.dart';
import 'package:moxy/domain/models/attributes.dart';

class ConfigMapper {
  Attributes mapToAttributes(NetworkAttributesResponse network) {
    return Attributes(
      colors: network.colors.map((e) => mapToColor(e)).toList(),
      sizes: network.sizes.map((e) => mapToSize(e)).toList(),
      materials: network.materials.map((e) => mapToMaterial(e)).toList(),
    );
  }

  Color mapToColor(NetworkColor network) {
    return Color(
      id: network.id,
      name: network.name,
      hexCode: network.hexCode,
    );
  }

  Size mapToSize(NetworkSize network) {
    return Size(
      id: network.id,
      name: network.name,
    );
  }

  Material mapToMaterial(NetworkMaterial network) {
    return Material(
      id: network.id,
      name: network.name,
    );
  }
}
