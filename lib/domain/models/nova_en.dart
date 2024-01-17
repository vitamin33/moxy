import 'package:moxy/data/models/response/nova_network.dart';

class NovaEN {
  final String ref;
  final String description;
  final String dateTime;
  final String cost;
  final String cityRecepientRef;
  final String contactRecipientRef;
  final String recipientPhone;
  final String cityRecipientDescription;
  final String recipientContactPerson;
  final String recipientAddressDescription;

  NovaEN(
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

  factory NovaEN.fromNetwork(NovaNetworkEN networkEn) {
    return NovaEN(
      networkEn.ref,
      networkEn.description,
      networkEn.dateTime,
      networkEn.cost,
      networkEn.cityRecepientRef,
      networkEn.contactRecipientRef,
      networkEn.recipientPhone,
      networkEn.cityRecipientDescription,
      networkEn.recipientContactPerson,
      networkEn.recipientAddressDescription,
    );
  }
}
