import '../copyable.dart';

class Warehouse implements Copyable<Warehouse> {
  final String ref;
  final String postMachineType;
  final int number;

  Warehouse({
    required this.ref,
    required this.postMachineType,
    required this.number,
  });

  static Warehouse defaultWarehouse() {
    return Warehouse(
      ref: '',
      postMachineType: '',
      number: 0,
    );
  }

  @override
  Warehouse copyWith({
    String? ref,
    String? postMachineType,
    int? number,
  }) {
    return Warehouse(
      ref: ref ?? this.ref,
      postMachineType: postMachineType ?? this.postMachineType,
      number: number ?? this.number,
    );
  }
}
