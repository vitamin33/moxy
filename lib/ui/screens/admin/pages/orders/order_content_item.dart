import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/constant/order_status.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/admin/all_orders/all_orders_cubit.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/status.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderItemContent extends StatelessWidget {
  final Order order;
  final String orderPrice;
  final String orderDate;
  final Function(LongPressStartDetails details) onLongPressStart;
  final Function() onTap;

  const OrderItemContent({
    super.key,
    required this.order,
    required this.orderPrice,
    required this.orderDate,
    required this.onLongPressStart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPressStart: onLongPressStart,
        onTap: onTap,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(14.0),
          tileColor: AppTheme.white,
          leading: Stack(children: [
            ClipOval(child: _buildImage(order.orderedItems)),
            Positioned(
              top: 22.0,
              left: 22.0,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: AppTheme.white,
                child: CircleAvatar(
                  backgroundColor: _mapStatusToColor(order.status),
                  radius: 12,
                  child: SvgPicture.asset(
                    order.status.iconPath,
                    width: 20,
                    color: AppTheme.white,
                  ),
                ),
              ),
            )
          ]),
          title: listTileTitle(order, theme),
          subtitle: listTileSubtitle(order, orderPrice, theme),
          trailing: listTileTrailing(order, orderDate, theme, context),
        ),
      ),
    );
  }

  listTileTitle(Order order, AppTheme theme) {
    return Row(
      children: [
        Text(
          '${order.client.firstName} ${order.client.secondName}',
          style: theme.largeBoltText,
        ),
        order.novaEN != null
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Image.asset(
                    ImageAssets.novaPoshta,
                    width: 20,
                    height: 20,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  listTileSubtitle(Order order, String orderPrice, AppTheme theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(order.orderedItems.map((item) => item.productName).join(', '),
            style: theme.smallText),
        Text(
          '$orderPrice $uah',
          style: theme.largeBoltText.copyWith(color: AppTheme.black),
        ),
      ],
    );
  }

  listTileTrailing(
      Order order, String orderDate, AppTheme theme, BuildContext context) {
    return Column(
      children: [
        Text(_mapStatusToStringValue(order.status, context),
            style: theme.largeText
                .copyWith(color: _mapStatusToColor(order.status))),
        const SizedBox(height: 8),
        Text(
          orderDate,
          style: theme.smallText,
        ),
      ],
    );
  }

  void showPopupMenu(BuildContext context, Order order, AllOrdersCubit cubit,
      LongPressStartDetails details, AppTheme theme) {
    final offset = details.globalPosition;
    final allStatusOrder = getAllStatusOrder(context);

    final RelativeRect position = RelativeRect.fromLTRB(
      offset.dx,
      offset.dy,
      MediaQuery.of(context).size.width - offset.dx,
      MediaQuery.of(context).size.height - offset.dy,
    );

    showMenu(
        color: AppTheme.pinkDark,
        surfaceTintColor: AppTheme.gray,
        context: context,
        position: position,
        initialValue: order.status.statusValue.name,
        items: allStatusOrder
            .map(
              (status) => PopupMenuItem<String>(
                onTap: () {
                  cubit.changedStatus(status, order.id!);
                },
                value: status.statusTitle,
                child: Text(
                  status.statusTitle,
                  style: theme.headlineText.copyWith(color: AppTheme.white),
                ),
              ),
            )
            .toList());
  }

  Color _mapStatusToColor(Status status) {
    switch (status.statusValue) {
      case OrderStatus.Returned:
      case OrderStatus.Canceled:
      case OrderStatus.PaymentFailed:
        return AppTheme.red;
      case OrderStatus.Sale:
      case OrderStatus.Sent:
        return AppTheme.greenDark;
      case OrderStatus.Paid:
        return AppTheme.orange;
      default:
        return AppTheme.greyDark;
    }
  }

  Widget _buildImage(List<OrderedItem> products) {
    bool noDimensions = products.any((element) => element.dimensions.isEmpty);
    bool noImages = products.any((element) =>
        element.dimensions.any((element) => element.images.isEmpty));
    if (products.isEmpty || noDimensions || noImages) {
      return Image.asset(
        width: 50,
        height: 50,
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
      );
    } else {
      String firstImageUrl =
          products.first.dimensions.first.images.first.imagePath;
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: firstImageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      );
    }
  }

  _mapStatusToStringValue(Status status, BuildContext context) {
    switch (status.statusValue) {
      case OrderStatus.Reserved:
        return AppLocalizations.of(context)!.statusReserved;
      case OrderStatus.Paid:
        return AppLocalizations.of(context)!.statusPaid;
      case OrderStatus.Sent:
        return AppLocalizations.of(context)!.statusSent;
      case OrderStatus.Sale:
        return AppLocalizations.of(context)!.statusSale;
      case OrderStatus.Canceled:
        return AppLocalizations.of(context)!.statusCanceled;
      case OrderStatus.Returned:
        return AppLocalizations.of(context)!.statusReturned;
      case OrderStatus.PaymentFailed:
        return AppLocalizations.of(context)!.statusPaymentFailed;
    }
  }
}
