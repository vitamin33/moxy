import 'package:moxy/constant/home_media.dart';
import 'package:moxy/domain/copyable.dart';

class Media implements Copyable<Media> {
  final String id;
  final MediaType mediaType;
  final List<String> mediaUrls;
  final String productId;

  Media({
    required this.id,
    required this.mediaType,
    required this.mediaUrls,
    required this.productId,
  });

  static Media defaultMedia() {
    return Media(
      id: '',
      mediaType: MediaType.image,
      mediaUrls: [],
      productId: '',
    );
  }

  @override
  Media copyWith({
    String? id,
    MediaType? mediaType,
    List<String>? mediaUrls,
    String? productId,
  }) {
    return Media(
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      productId: productId ?? this.productId,
    );
  }
}
