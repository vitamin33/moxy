import 'package:moxy/constant/home_media.dart';
import 'package:moxy/domain/copyable.dart';

class Media implements Copyable<Media> {
  final String id;
  final MediaType mediaType;
  final List<String> mediaUrls;
  

  Media({
    required this.id,
    required this.mediaType,
    required this.mediaUrls,
  });

  static Media defaultMedia() {
    return Media(
      id: '',
      mediaType: MediaType.image,
      mediaUrls: [],
    );
  }

  @override
  Media copyWith({
    String? id,
   MediaType? mediaType,
   List<String>? mediaUrls,
  }) {
    return Media(
      id: id ?? this.id,
      mediaType: mediaType ?? this.mediaType,
      mediaUrls: mediaUrls ?? this.mediaUrls,
    );
  }
}