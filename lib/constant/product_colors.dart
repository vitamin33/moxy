import 'package:moxy/domain/models/product.dart';

List<Dimension> allColorsDimens = [
  Dimension(
      color: 'Black',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/black_background.png'),
  Dimension(
      color: 'White',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/white_background.png'),
  Dimension(
      color: 'Grey',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/grey_background.png'),
  Dimension(
      color: 'Pink',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/pink_background.png'),
  Dimension(
      color: 'PinkLeo',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/pinkLeo_background.png'),
  Dimension(
      color: 'Leo',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/leo_background.png'),
  Dimension(
      color: 'Brown',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/brown_background.png'),
  Dimension(
      color: 'Beige',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/beige_background.png'),
  Dimension(
      color: 'Purple',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/purple_background.png'),
  Dimension(
      color: 'Zebra',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/zebra_background.png'),
  Dimension(
      color: 'Jeans',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/jeans_background.png'),
  Dimension(
      color: 'Green',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/green_background.png'),
  Dimension(
      color: 'Bars',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/bars_background.png'),
  Dimension(
      color: 'Unified',
      quantity: 0,
      isSelected: false,
      image: 'assets/images/unified_background.png'),
];

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
  bars('Bars'),
  unified('Unified');

  final String color;
  const ProductColor(this.color);
}
