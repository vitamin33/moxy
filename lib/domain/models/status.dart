import 'package:moxy/constant/icon_path.dart';

class Status {
  final String iconPath;
  final String statusTitle;
  bool isSelected;

  Status(
      {required this.iconPath,
      required this.isSelected,
      required this.statusTitle});

  static Status defaultStatus() {
    return Status(
        iconPath: IconPath.newStatus, statusTitle: 'New', isSelected: true);
  }

  void toggleSelected() {
    isSelected = !isSelected;
  }
}
