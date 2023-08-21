import 'package:moxy/constant/icon_path.dart';

import '../../constant/order_status.dart';

class Promo {
  final String imageUrl;
  final int salePrecentage;
  final String title;
  final String productName;

  Promo(
      {required this.imageUrl,
      required this.salePrecentage,
      required this.title,
      required this.productName});

  static Promo defaultPromo() {
    return Promo(imageUrl: '', salePrecentage: 0, title: '', productName: '');
  }

  Promo copyWith({
    String? imageUrl,
    int? salePrecentage,
    String? title,
    String? productName,
  }) {
    return Promo(
      imageUrl: imageUrl ?? this.imageUrl,
      salePrecentage: salePrecentage ?? this.salePrecentage,
      title: title ?? this.title,
      productName: productName ?? this.productName,
    );
  }
}
