import 'package:moxy/domain/copyable.dart';

class ProductAdvantages implements Copyable<ProductAdvantages> {
  final String header;
  final String imageUrl;
  final String description;

  ProductAdvantages(
      {required this.header,
      required this.imageUrl,
      required this.description});

  static ProductAdvantages defaultProductAdvantages() {
    return ProductAdvantages(
      header: '',
      imageUrl: '',
      description: '',
    );
  }

  @override
  ProductAdvantages copyWith({
    String? header,
    String? imageUrl,
    String? description,
  }) {
    return ProductAdvantages(
      header: header ?? this.header,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }
}
