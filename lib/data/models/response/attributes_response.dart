import 'package:freezed_annotation/freezed_annotation.dart';

part 'attributes_response.g.dart';

@JsonSerializable()
class NetworkAttributesResponse {
  List<NetworkColor> colors;
  List<NetworkSize> sizes;
  List<NetworkMaterial> materials;

  NetworkAttributesResponse(this.colors, this.sizes, this.materials);

  factory NetworkAttributesResponse.fromJson(Map<String, dynamic> json) =>
      _$NetworkAttributesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkAttributesResponseToJson(this);
}

@JsonSerializable()
class NetworkSize {
  @JsonKey(name: '_id')
  String id;
  String name;

  NetworkSize({
    required this.id,
    required this.name,
  });

  factory NetworkSize.fromJson(Map<String, dynamic> json) =>
      _$NetworkSizeFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkSizeToJson(this);
}

@JsonSerializable()
class NetworkMaterial {
  @JsonKey(name: '_id')
  String id;
  String name;

  NetworkMaterial({
    required this.id,
    required this.name,
  });

  factory NetworkMaterial.fromJson(Map<String, dynamic> json) =>
      _$NetworkMaterialFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkMaterialToJson(this);
}

@JsonSerializable()
class NetworkColor {
  @JsonKey(name: '_id')
  String id;
  String name;
  String hexCode;

  NetworkColor({
    required this.id,
    required this.name,
    required this.hexCode,
  });

  factory NetworkColor.fromJson(Map<String, dynamic> json) =>
      _$NetworkColorFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkColorToJson(this);
}
