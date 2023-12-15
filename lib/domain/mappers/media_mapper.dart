import 'package:moxy/constant/home_media.dart';
import 'package:moxy/data/models/response/media_response.dart';
import 'package:moxy/domain/models/media.dart';

class MediaMapper {
  List<Media> mapToMedia(List<NetworkMedia> networkMedia) {
    return networkMedia.map(
      (e) {
        return Media(
            id: e.id,
            mediaType: _mapMediaTypeNetwork(e.type),
            mediaUrls: e.mediaUrls);
      },
    ).toList();
  }

  MediaType _mapMediaTypeNetwork(String paymentType) {
    switch (paymentType) {
      case 'Image':
        return MediaType.image;
      case 'ImageSet':
        return MediaType.imageSet;
      case 'Video':
        return MediaType.video;
    }
    return MediaType.image;
  }
}
