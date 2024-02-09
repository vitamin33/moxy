class FilterPrice {
  final String name;
  bool isSelected;

  FilterPrice({
    required this.name,
    required this.isSelected,
  });

  static FilterPrice defaultFilterPrice() {
    return FilterPrice(
      isSelected: true,
      name: '',
    );
  }

  FilterPrice copyWith({
    String? name,
    bool? isSelected,
  }) {
    return FilterPrice(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
