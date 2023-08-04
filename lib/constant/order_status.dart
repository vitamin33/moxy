// import 'package:flutter/cupertino.dart';
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
        iconPath: IconPath.newStatus),
    Status(
        statusTitle: l10n.statusPaid,
        isSelected: false,
        iconPath: IconPath.paidStatus),
    Status(
        statusTitle: l10n.statusSent,
        isSelected: false,
        iconPath: IconPath.sentStatus),
    Status(
        statusTitle: l10n.statusSale,
        isSelected: false,
        iconPath: IconPath.saleStatus),
    Status(
        statusTitle: l10n.statusCanceled,
        isSelected: false,
        iconPath: IconPath.canceledStatus),
    Status(
        statusTitle: l10n.statusReturned,
        isSelected: false,
        iconPath: IconPath.returnedStatus),
  ];
}

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
