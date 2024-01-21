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
  final String recipientAddressRef;
  final String docNumber;

  NovaEN({
    required this.ref,
    required this.description,
    required this.dateTime,
    required this.cityRecepientRef,
    required this.cost,
    required this.contactRecipientRef,
    required this.cityRecipientDescription,
    required this.recipientAddressDescription,
    required this.recipientContactPerson,
    required this.recipientPhone,
    required this.recipientAddressRef,
    required this.docNumber,
  });

  factory NovaEN.fromNetwork(NovaNetworkEN networkEn) {
    return NovaEN(
      ref: networkEn.ref,
      description: networkEn.description,
      dateTime: networkEn.dateTime,
      cost: networkEn.cost,
      cityRecepientRef: networkEn.cityRecepientRef,
      contactRecipientRef: networkEn.contactRecipientRef,
      recipientPhone: networkEn.recipientPhone,
      recipientContactPerson: networkEn.recipientContactPerson,
      recipientAddressDescription: networkEn.recipientAddressDescription,
      cityRecipientDescription: networkEn.cityRecipientDescription,
      recipientAddressRef: networkEn.recipientAddressRef,
      docNumber: networkEn.docNumber,
    );
  }
}
