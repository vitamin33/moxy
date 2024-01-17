import 'package:freezed_annotation/freezed_annotation.dart';

part 'nova_network.g.dart';

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

@JsonSerializable()
class NovaNetworkWarehouse {
  @JsonKey(name: 'TypeOfWarehouse')
  final String ref;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'PostMachineType')
  final String postMachineType;
  @JsonKey(name: 'Number')
  final String number;

  NovaNetworkWarehouse(
    this.ref,
    this.description,
    this.postMachineType,
    this.number,
  );

  factory NovaNetworkWarehouse.fromJson(Map<String, dynamic> json) =>
      _$NovaNetworkWarehouseFromJson(json);

  Map<String, dynamic> toJson() => _$NovaNetworkWarehouseToJson(this);
}

@JsonSerializable()
class NovaNetworkEN {
  @JsonKey(name: 'Ref')
  final String ref;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'DateTime')
  final String dateTime;
  @JsonKey(name: 'Cost')
  final String cost;
  @JsonKey(name: 'CityRecipient')
  final String cityRecepientRef;
  @JsonKey(name: 'ContactRecipient')
  final String contactRecipientRef;
  @JsonKey(name: 'RecipientsPhone')
  final String recipientPhone;
  @JsonKey(name: 'CityRecipientDescription')
  final String cityRecipientDescription;
  @JsonKey(name: 'RecipientContactPerson')
  final String recipientContactPerson;
  @JsonKey(name: 'RecipientAddressDescription')
  final String recipientAddressDescription;

  NovaNetworkEN(
    this.ref,
    this.description,
    this.dateTime,
    this.cityRecepientRef,
    this.cost,
    this.contactRecipientRef,
    this.cityRecipientDescription,
    this.recipientAddressDescription,
    this.recipientContactPerson,
    this.recipientPhone,
  );

  factory NovaNetworkEN.fromJson(Map<String, dynamic> json) =>
      _$NovaNetworkENFromJson(json);

  Map<String, dynamic> toJson() => _$NovaNetworkENToJson(this);
}
