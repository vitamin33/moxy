import 'package:moxy/domain/models/product.dart';

Set<Dimension> allColorsDimens = {
  Dimension(color: 'Black', quantity: 0,isSelected: false),
  Dimension(color: 'White', quantity: 0,isSelected: false),
  Dimension(color: 'Grey', quantity: 0,isSelected: false),
  Dimension(color: 'Pink', quantity: 0,isSelected: false),
  Dimension(color: 'PinkLeo', quantity: 0,isSelected: false),
  Dimension(color: 'Leo', quantity: 0,isSelected: false),
  Dimension(color: 'Brown', quantity: 0,isSelected: false),
  Dimension(color: 'Beige', quantity: 0,isSelected: false),
  Dimension(color: 'Purple', quantity: 0,isSelected: false),
  Dimension(color: 'Zebra', quantity: 0,isSelected: false),
  Dimension(color: 'Jeans', quantity: 0,isSelected: false),
  Dimension(color: 'Green', quantity: 0,isSelected: false),
  Dimension(color: 'Bars', quantity: 0,isSelected: false),
  Dimension(color: 'Unified', quantity: 0,isSelected: false),
};

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
