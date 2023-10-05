import 'package:moxy/data/models/response/attributes_response.dart';
import 'package:moxy/domain/models/attributes.dart';
import 'package:moxy/domain/models/product.dart';

class ConfigMapper {
  Attributes mapToAttributes(NetworkAttributesResponse network) {
    return Attributes(
      colors: network.colors.map((e) => mapToColor(e)).toList(),
      sizes: network.sizes.map((e) => mapToSize(e)).toList(),
      materials: network.materials.map((e) => mapToMaterial(e)).toList(),
    );
  }

  ProductColor mapToColor(NetworkColor network) {
    return ProductColor(
      id: network.id,
      name: network.name,
      hexCode: network.hexCode,
    );
  }

  ProductSize mapToSize(NetworkSize network) {
    return ProductSize(
      id: network.id,
      name: network.name,
    );
  }

  ProductMaterial mapToMaterial(NetworkMaterial network) {
    return ProductMaterial(
      id: network.id,
      name: network.name,
    );
  }
}
