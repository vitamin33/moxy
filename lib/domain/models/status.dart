import 'package:moxy/constant/icon_path.dart';

import '../../constant/order_status.dart';

class Status {
  final String iconPath;
  final String statusTitle;
  final OrderStatus statusValue;
  bool isSelected;

  Status(
      {required this.iconPath,
      required this.isSelected,
      required this.statusTitle,
      required this.statusValue});

  static Status defaultStatus() {
    return Status(
        iconPath: IconPath.newStatus,
        statusTitle: 'New',
        isSelected: true,
        statusValue: OrderStatus.New);
  }

  Status copyWith({
    String? iconPath,
    String? statusTitle,
    OrderStatus? statusValue,
    bool? isSelected,
  }) {
    return Status(
      iconPath: iconPath ?? this.iconPath,
      statusTitle: statusTitle ?? this.statusTitle,
      statusValue: statusValue ?? this.statusValue,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  void toggleSelected() {
    isSelected = !isSelected;
  }
}
