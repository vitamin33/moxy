import 'package:flutter/material.dart';
import 'package:moxy/constant/icon_path.dart';

import '../domain/models/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Status> getAllStatusOrder(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return [
    Status(
        statusTitle: l10n.statusNew,
        isSelected: false,
        iconPath: IconPath.newStatus,
        statusValue: OrderStatus.New
        ),
    Status(
        statusTitle: l10n.statusPaid,
        isSelected: false,
        iconPath: IconPath.paidStatus,
        statusValue: OrderStatus.Paid),
    Status(
        statusTitle: l10n.statusSent,
        isSelected: false,
        iconPath: IconPath.sentStatus,
        statusValue: OrderStatus.Sent),
    Status(
        statusTitle: l10n.statusSale,
        isSelected: false,
        iconPath: IconPath.saleStatus,
        statusValue: OrderStatus.Sale),
    Status(
        statusTitle: l10n.statusCanceled,
        isSelected: false,
        iconPath: IconPath.canceledStatus,
        statusValue: OrderStatus.Canceled),
    Status(
        statusTitle: l10n.statusReturned,
        isSelected: false,
        iconPath: IconPath.returnedStatus,
        statusValue: OrderStatus.Returned),
  ];
}

List<Status> allStatusOrder = [
  Status(statusTitle: 'New', isSelected: false, iconPath: IconPath.newStatus,
        statusValue: OrderStatus.New),
  Status(statusTitle: 'Paid', isSelected: false, iconPath: IconPath.paidStatus,
        statusValue: OrderStatus.Paid),
  Status(statusTitle: 'Sent', isSelected: false, iconPath: IconPath.sentStatus,
        statusValue: OrderStatus.Sent),
  Status(statusTitle: 'Sale', isSelected: false, iconPath: IconPath.saleStatus,
        statusValue: OrderStatus.Sale),
  Status(
      statusTitle: 'Canceled',
      isSelected: false,
      iconPath: IconPath.canceledStatus,
        statusValue: OrderStatus.Canceled),
  Status(
      statusTitle: 'Returned',
      isSelected: false,
      iconPath: IconPath.returnedStatus,
        statusValue: OrderStatus.Returned),
];

 enum  OrderStatus{
  New, Paid, Sent, Sale, Canceled, Returned;
}
