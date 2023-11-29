import 'package:moxy/domain/copyable.dart';

class ProductAdvatages implements Copyable<ProductAdvatages> {
  final String header;
  final String imageUrl;
  final String description;

  ProductAdvatages(
      {required this.header,
      required this.imageUrl,
      required this.description});

  static ProductAdvatages defaultProductAdvatages() {
    return ProductAdvatages(
      header: '',
      imageUrl: '',
      description: '',
    );
  }

  @override
  ProductAdvatages copyWith({
    String? header,
    String? imageUrl,
    String? description,
  }) {
    return ProductAdvatages(
      header: header ?? this.header,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
    );
  }
}
