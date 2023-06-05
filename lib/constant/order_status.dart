import 'package:moxy/constant/icon_path.dart';

import '../domain/models/status.dart';

List<Status> allStatusOrder = [
  Status(statusTitle: 'New', isSelected: false, iconPath: IconPath.newStatus),
  Status(statusTitle: 'Paid', isSelected: false, iconPath: IconPath.paidStatus),
  Status(statusTitle: 'Sent', isSelected: false, iconPath: IconPath.sentStatus),
  Status(statusTitle: 'Sale', isSelected: false, iconPath: IconPath.saleStatus),
  Status(
      statusTitle: 'Canceled',
      isSelected: false,
      iconPath: IconPath.canceledStatus),
  Status(
      statusTitle: 'Returned',
      isSelected: false,
      iconPath: IconPath.returnedStatus),
];


