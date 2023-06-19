import 'package:freezed_annotation/freezed_annotation.dart';

part 'nova_network_city.g.dart';

@JsonSerializable()
class NovaNetworkCity {
  @JsonKey(name: 'MainDescription')
  final String mainDescription;
  @JsonKey(name: 'Ref')
  final String ref;
  @JsonKey(name: 'DeliveryCity')
  final String deliveryCityRef;
  @JsonKey(name: 'Present')
  final String presentName;

  NovaNetworkCity(
      this.mainDescription, this.ref, this.deliveryCityRef, this.presentName);

  factory NovaNetworkCity.fromJson(Map<String, dynamic> json) =>
      _$NovaNetworkCityFromJson(json);

  Map<String, dynamic> toJson() => _$NovaNetworkCityToJson(this);
}
