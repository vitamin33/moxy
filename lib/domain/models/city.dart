import '../copyable.dart';

class City implements Copyable<City> {
  final String mainDescription;
  final String ref;
  final String deliveryCityRef;
  final String presentName;

  City({
    required this.mainDescription,
    required this.ref,
    required this.deliveryCityRef,
    required this.presentName,
  });

  static City defaultCity() {
    return City(
      mainDescription: '',
      ref: '',
      deliveryCityRef: '',
      presentName: '',
    );
  }

  @override
  City copyWith({
    String? mainDescription,
    String? ref,
    String? deliveryCityRef,
    String? presentName,
  }) {
    return City(
      mainDescription: mainDescription ?? this.mainDescription,
      ref: ref ?? this.ref,
      deliveryCityRef: deliveryCityRef ?? this.deliveryCityRef,
      presentName: presentName ?? this.presentName,
    );
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(City city) {
    return ref == city.ref;
  }

  @override
  String toString() => presentName;
}
