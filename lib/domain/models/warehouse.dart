import 'package:moxy/domain/models/nova_en.dart';
import 'package:moxy/utils/common.dart';

import '../copyable.dart';

class Warehouse implements Copyable<Warehouse> {
  final String ref;
  final String? postMachineType;
  final String description;
  final int number;

  Warehouse({
    required this.ref,
    required this.postMachineType,
    required this.description,
    required this.number,
  });

  factory Warehouse.fromEN(NovaEN en) {
    int? number;
    try {
      // Regular expression to find a number following the '№' sign
      RegExp regExp = RegExp(r'№(\d+)');
      var match = regExp.firstMatch(en.recipientAddressDescription);

      if (match != null) {
        number = int.parse(match.group(1)!);
      }
    } catch (e) {
      moxyPrint('Unable to parse Nova Post number');
    }

    return Warehouse(
      ref: en.cityRecepientRef,
      description: en.recipientAddressDescription,
      postMachineType: null,
      number: number ?? 0,
    );
  }

  static Warehouse defaultWarehouse() {
    return Warehouse(
      ref: '',
      postMachineType: '',
      description: '',
      number: 0,
    );
  }

  @override
  Warehouse copyWith({
    String? ref,
    String? postMachineType,
    String? description,
    int? number,
  }) {
    return Warehouse(
      ref: ref ?? this.ref,
      postMachineType: postMachineType ?? this.postMachineType,
      description: description ?? this.description,
      number: number ?? this.number,
    );
  }
}
