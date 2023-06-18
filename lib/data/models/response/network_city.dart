import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_city.g.dart';

@JsonSerializable()
class NetworkCity {
  @JsonKey(name: 'MainDescription')
  final String mainDescription;
  @JsonKey(name: 'Ref')
  final String ref;
  @JsonKey(name: 'DeliveryCity')
  final String deliveryCityRef;
  @JsonKey(name: 'Present')
  final String presentName;

  NetworkCity(
      this.mainDescription, this.ref, this.deliveryCityRef, this.presentName);

  factory NetworkCity.fromJson(Map<String, dynamic> json) =>
      _$NetworkCityFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkCityToJson(this);
}
