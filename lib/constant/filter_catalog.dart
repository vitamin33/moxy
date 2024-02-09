import 'package:moxy/domain/models/filter_price.dart';
import 'package:moxy/domain/models/sort_by.dart';

List<FilterPrice> filterRangePrice = [
  FilterPrice(name: '400-800', isSelected: false),
  FilterPrice(name: '800-1200', isSelected: false),
  FilterPrice(name: '1200<', isSelected: false)
];
List<SortBy> filterTime = [
  SortBy(name: 'New-Old', isSelected: false),
  SortBy(name: 'Old-New', isSelected: false),
];
