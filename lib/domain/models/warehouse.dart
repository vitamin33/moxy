import '../copyable.dart';

class Warehouse implements Copyable<Warehouse> {
  final String ref;
  final String postMachineType;
  final String description;
  final int number;

  Warehouse({
    required this.ref,
    required this.postMachineType,
    required this.description,
    required this.number,
  });

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
