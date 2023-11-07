import 'package:flutter/material.dart';
import 'package:moxy/constant/icon_path.dart';

import '../domain/models/status.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

List<Status> getAllStatusOrder(BuildContext context,
    [List<OrderStatus> availableStatuses = const []]) {
  final l10n = AppLocalizations.of(context)!;
  return OrderStatus.values.map((status) {
    final isAvailable =
        availableStatuses.isEmpty || availableStatuses.contains(status);
    switch (status) {
      case OrderStatus.Reserved:
        return Status(
            statusTitle: l10n.statusReturned,
            isSelected: false,
            isAvailable: isAvailable,
            iconPath: IconPath.reservedStatus,
            statusValue: OrderStatus.Reserved);
      case OrderStatus.Paid:
        return Status(
            statusTitle: l10n.statusPaid,
            isSelected: false,
            isAvailable: isAvailable,
            iconPath: IconPath.paidStatus,
            statusValue: OrderStatus.Paid);
      case OrderStatus.Sent:
        return Status(
            statusTitle: l10n.statusSent,
            isSelected: false,
            isAvailable: isAvailable,
            iconPath: IconPath.sentStatus,
            statusValue: OrderStatus.Sent);
      case OrderStatus.Sale:
        return Status(
            statusTitle: l10n.statusSale,
            isSelected: false,
            isAvailable: isAvailable,
            iconPath: IconPath.saleStatus,
            statusValue: OrderStatus.Sale);
      case OrderStatus.Canceled:
        return Status(
            statusTitle: l10n.statusCanceled,
            isSelected: false,
            isAvailable: isAvailable,
            iconPath: IconPath.canceledStatus,
            statusValue: OrderStatus.Canceled);
      case OrderStatus.Returned:
        return Status(
            statusTitle: l10n.statusReturned,
            isSelected: false,
            isAvailable: isAvailable,
            iconPath: IconPath.returnedStatus,
            statusValue: OrderStatus.Returned);
      case OrderStatus.PaymentFailed:
        return Status(
            statusTitle: l10n.statusPaymentFailed,
            isSelected: false,
            iconPath: IconPath.paidStatus,
            isAvailable: isAvailable,
            statusValue: OrderStatus.PaymentFailed);
      // Add cases for other OrderStatus values
      default:
        return Status(
          statusTitle: '',
          isSelected: false,
          iconPath: '',
          statusValue: status,
          isAvailable: isAvailable,
        );
    }
  }).toList();
}

List<Status> allStatusOrder = [
  Status(
      statusTitle: 'Reserved',
      isSelected: false,
      iconPath: IconPath.reservedStatus,
      statusValue: OrderStatus.Reserved),
  Status(
      statusTitle: 'Paid',
      isSelected: false,
      iconPath: IconPath.paidStatus,
      statusValue: OrderStatus.Paid),
  Status(
      statusTitle: 'Sent',
      isSelected: false,
      iconPath: IconPath.sentStatus,
      statusValue: OrderStatus.Sent),
  Status(
      statusTitle: 'Sale',
      isSelected: false,
      iconPath: IconPath.saleStatus,
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
  Status(
      statusTitle: 'PaymentFailed',
      isSelected: false,
      iconPath: IconPath.paidStatus,
      statusValue: OrderStatus.PaymentFailed),
];

enum OrderStatus {
  Reserved,
  Paid,
  Sent,
  Sale,
  Canceled,
  Returned,
  PaymentFailed
}
