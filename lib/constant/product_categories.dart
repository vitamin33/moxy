List<String> categories = const [
  "Bag",
  "Small bag",
  "Fluffy bag",
  "Stylish bag",
];

enum ProductCategory { bags, accessories, backpacks }

extension ProductCategoryExtension on ProductCategory {
  String get urlSegment {
    switch (this) {
      case ProductCategory.bags:
        return 'Bags';
      case ProductCategory.accessories:
        return 'Accessories';
      case ProductCategory.backpacks:
        return 'Backpacks';
    }
  }
}
