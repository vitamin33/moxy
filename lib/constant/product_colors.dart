// List<String> productColors = const [
//   'Black',
//   'White',
//   'Grey',
//   'Pink',
//   'PinkLeo',
//   'Leo',
//   'Brown',
//   'Beige',
//   'Purple',
//   'Zebra',
//   'Jeans',
//   'Green',
//   'Bars',
//   'Unified'
// ];


enum ProductColor {
  black('Black'),
  white('White'),
  grey('Grey'),
  pink('Pink'),
  pinkLeo('PinkLeo'),
  leo('Leo'),
  brown('Brown'),
  beige('Beige'),
  purple('Purple'),
  zebra('Zebra'),
  jeans('Jeans'),
  green('Green'),
  bars('Bars');

  final String color;
  const ProductColor(this.color);
}
