import 'package:json_annotation/json_annotation.dart';

part 'media_response.g.dart';

@JsonSerializable()
class NetworkMedia {
 @JsonKey(name: '_id')
  String id;
  String type;
  List<String> mediaUrls;
  bool activeHome;

  NetworkMedia({
    required this.id,
    required this.type,
    required this.mediaUrls,
    required this.activeHome,
  });

  factory NetworkMedia.fromJson(Map<String, dynamic> json) =>
      _$NetworkMediaFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkMediaToJson(this);
}