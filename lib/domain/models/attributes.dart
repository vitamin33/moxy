import '../copyable.dart';

class Attributes implements Copyable<Attributes> {
  List<Color> colors;
  List<Material> materials;
  List<Size> sizes;

  Attributes({
    required this.sizes,
    required this.colors,
    required this.materials,
  });

  static Attributes defaultAttributes() {
    return Attributes(
      materials: [],
      colors: [],
      sizes: [],
    );
  }

  @override
  Attributes copyWith({
    List<Size>? sizes,
    List<Material>? materials,
    List<Color>? colors,
  }) {
    return Attributes(
      materials: materials ?? this.materials,
      colors: colors ?? this.colors,
      sizes: sizes ?? this.sizes,
    );
  }
}

class Size implements Copyable<Size> {
  String id;
  String name;

  Size({
    required this.id,
    required this.name,
  });

  static Size defaultSize() {
    return Size(
      id: '',
      name: '',
    );
  }

  @override
  Size copyWith({
    String? name,
    String? hexCode,
  }) {
    return Size(
      id: id,
      name: name ?? this.name,
    );
  }
}

class Material implements Copyable<Material> {
  String id;
  String name;

  Material({
    required this.id,
    required this.name,
  });

  static Material defaultMaterial() {
    return Material(
      id: '',
      name: '',
    );
  }

  @override
  Material copyWith({
    String? name,
    String? hexCode,
  }) {
    return Material(
      id: id,
      name: name ?? this.name,
    );
  }
}

class Color implements Copyable<Color> {
  String id;
  String name;
  String hexCode;

  Color({
    required this.id,
    required this.name,
    required this.hexCode,
  });

  static Color defaultColor() {
    return Color(
      id: '',
      name: '',
      hexCode: '',
    );
  }

  @override
  Color copyWith({
    String? name,
    String? hexCode,
  }) {
    return Color(
      id: id,
      name: name ?? this.name,
      hexCode: hexCode ?? this.hexCode,
    );
  }
}
