import 'package:moxy/domain/mappers/product_mapper.dart';

import '../../data/models/response/all_promos_response.dart';
import '../../services/get_it.dart';
import '../models/promo.dart';

class PromoMapper {
  final productMapper = locate<ProductMapper>();
  List<Promo> mapToPromo(List<NetworkPromos> networkPromos) {
    return networkPromos.map(
      (p) {
        return Promo(
            imageUrl: p.imageUrl,
            discount: p.discount,
            title: p.title,
            productId: p.productId,
            product: productMapper.mapToProduct(p.product!),
            finalDate: DateTime.tryParse(p.finalDate!));
      },
    ).toList();
  }
}
