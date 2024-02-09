class SortBy {
  final String name;
  bool isSelected;

  SortBy({
    required this.name,
    required this.isSelected,
  });

  static SortBy defaultSortBy() {
    return SortBy(
      isSelected: true,
      name: '',
    );
  }

  SortBy copyWith({
    String? name,
    bool? isSelected,
  }) {
    return SortBy(
      name: name ?? this.name,
      isSelected: isSelected ?? this.isSelected,
    );
  }

}