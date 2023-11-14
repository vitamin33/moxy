import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_cubit.dart';
import 'package:moxy/domain/models/order.dart';
import 'package:moxy/domain/models/status.dart';

import '../../../../../constant/order_status.dart';
import '../../../../../services/navigation/admin/admin_home_router_cubit.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../../domain/admin/all_orders/all_orders_cubit.dart';
import '../../../../../domain/admin/all_orders/all_orders_state.dart';
import '../../../../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isFilterChipsVisible = true;
  double _toolbarHeight = 0;
  Status? selectedMenu;
  late AllOrdersCubit cubit;

  final GlobalKey _wrapKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    cubit = context.read<AllOrdersCubit>();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateWrapHeight();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      setState(() {
        _isFilterChipsVisible = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      setState(() {
        _isFilterChipsVisible = true;
      });
    }
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        cubit.state.hasMoreOrders &&
        !cubit.state.isLoading) {
      cubit.fetchOrders(cubit.state.currentPage + 1);
    }
  }

  void _calculateWrapHeight() {
    final RenderBox? wrapBox =
        _wrapKey.currentContext?.findRenderObject() as RenderBox?;
    if (wrapBox != null && wrapBox.hasSize) {
      setState(() {
        _toolbarHeight = wrapBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AllOrdersCubit>();
    return BlocConsumer<AllOrdersCubit, AllOrdersState>(
        listener: (context, state) {
      if (state.errorMessage != '') {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Failed:${state.errorMessage}'));
      }
    }, builder: (context, state) {
      final showTopBar = _isFilterChipsVisible && state.hasFilters();
      _toolbarHeight = showTopBar
          ? 75.0
          : 0.0; // Update the toolbar height based on showTopBar

      return Scaffold(
        body: Material(
          color: AppTheme.pink,
          child: Stack(children: [
            _buildLoadingIfNeeded(state),
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                _buildTopAppBar(cubit, state, showTopBar),
                CupertinoSliverRefreshControl(
                  refreshTriggerPullDistance: 80,
                  refreshIndicatorExtent: 50,
                  onRefresh: () => cubit.refreshOrderList(),
                ),
                _buildOrdersListWidget(cubit, state),
              ],
            )
          ]),
        ),
      );
    });
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

  List<Widget> _filterChipsList(
      BuildContext context, AllOrdersCubit cubit, AllOrdersState state) {
    List<Widget> chipsList = [];

    if (state.deliveryFilter != FilterDeliveryType.empty) {
      chipsList.add(
        Padding(
          padding: const EdgeInsets.all(5),
          child: FilterChip(
            avatar: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.close,
              ),
            ),
            label: Text(state.deliveryFilter!.name.toString()),
            side: const BorderSide(color: Colors.white),
            onSelected: (selected) {
              if (selected) {
                cubit.clearDeliveryTypeFilter();
              }
            },
          ),
        ),
      );
    }
    if (state.paymentFilter != FilterPaymentType.empty) {
      chipsList.add(
        Padding(
          padding: const EdgeInsets.all(5),
          child: FilterChip(
            avatar: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.close,
              ),
            ),
            label: Text(state.paymentFilter!.name.toString()),
            side: const BorderSide(color: Colors.white),
            onSelected: (selected) {
              if (selected) {
                cubit.clearPaymentTypeFilter();
              }
            },
          ),
        ),
      );
    }
    if (state.statusFilter?.isNotEmpty == true) {
      chipsList.add(
        Padding(
          padding: const EdgeInsets.all(5),
          child: FilterChip(
            backgroundColor: AppTheme.white,
            avatar: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.close,
              ),
            ),
            label: Text(state.statusFilter!
                .map((status) => _mapStatusToStringValue(status, context))
                .join(', ')),
            side: const BorderSide(color: Colors.white),
            onSelected: (selected) {
              if (selected) {
                cubit.clearStatusFilter();
              }
            },
          ),
        ),
      );
    }
    if (state.dateRangeFilter != null) {
      String firstDate = DateFormat('dd MM yyyy')
          .format(DateTime.parse(state.dateRangeFilter!.start.toString()));
      String lastDate = DateFormat('dd MM yyyy')
          .format(DateTime.parse(state.dateRangeFilter!.end.toString()));
      chipsList.add(
        Padding(
          padding: const EdgeInsets.all(5),
          child: FilterChip(
            avatar: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.close,
                )),
            label: Text('$firstDate-$lastDate'),
            side: const BorderSide(color: Colors.white),
            onSelected: (selected) {
              if (selected) {
                cubit.clearDateRangeFilter();
              }
            },
          ),
        ),
      );
    }
    return chipsList;
  }

  Widget _buildTopAppBar(
      AllOrdersCubit cubit, AllOrdersState state, bool showTopBar) {
    return SliverAppBar(
      backgroundColor: AppTheme.pink,
      surfaceTintColor: AppTheme.pink,
      floating: true,
      pinned: true,
      snap: true,
      toolbarHeight: _toolbarHeight,
      title: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _toolbarHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (showTopBar) {
              final wrapHeight = constraints.maxHeight;
              _toolbarHeight = wrapHeight;
            } else {
              _toolbarHeight = 0.0;
            }
            return AnimatedOpacity(
              opacity: showTopBar ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Stack(
                children: [
                  _buildLoadingIfNeeded(state),
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceAround,
                    children: _filterChipsList(context, cubit, state),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrdersListWidget(AllOrdersCubit cubit, AllOrdersState state) {
    return SliverToBoxAdapter(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: state.hasMoreOrders
            ? state.allOrders.length + 1
            : state.allOrders.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < state.allOrders.length) {
            final order = state.allOrders[index];
            DateTime dateTime = DateTime.parse(order.createdAt.toString());
            String orderDate = DateFormat("hh:mm  dd/MM").format(dateTime);
            final orderPrice = order.orderedItems
                .map((item) => item.fullOrderPrice())
                .reduce((total, price) => total + price)
                .toString();
            return _buildOrderItemWidget(cubit, order, orderDate, orderPrice);
          } else if (state.isLoading) {
            return const Center(
              child: LinearProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }

  _mapStatusToStringValue(Status status, BuildContext context) {
    switch (status.statusValue) {
      case OrderStatus.Reserved:
        return AppLocalizations.of(context)!.statusReturned;
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

  listTileTitle(Order order) {
    return Text(
      '${order.client.firstName} ${order.client.secondName}',
      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    );
  }

  listTileSubtitle(Order order, String orderPrice) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(order.orderedItems.map((item) => item.productName).join(', '),
            style: const TextStyle(
              fontSize: 13,
            )),
        Text(
          '$orderPrice $uah',
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.black),
        ),
      ],
    );
  }

  listTileTrailing(Order order, String orderDate) {
    return Column(
      children: [
        Text(_mapStatusToStringValue(order.status, context),
            style: TextStyle(
                fontSize: 16, color: _mapStatusToColor(order.status))),
        const SizedBox(height: 8),
        Text(
          orderDate,
          style: const TextStyle(fontSize: 13),
        ),
      ],
    );
  }

  void showPopupMenu(BuildContext context, Order order, AllOrdersCubit cubit,
      LongPressStartDetails details) {
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
                  style: const TextStyle(fontSize: 18, color: AppTheme.white),
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

  Widget _buildLoadingIfNeeded(AllOrdersState state) {
    return state.isLoading
        ? const LinearProgressIndicator(
            color: AppTheme.pinkDark,
            backgroundColor: AppTheme.pink,
          )
        : Container();
  }

  Widget _buildOrderItemWidget(
      AllOrdersCubit cubit, Order order, String orderDate, String orderPrice) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPressStart: (details) =>
            showPopupMenu(context, order, cubit, details),
        onTap: () {
          context
              .read<AdminHomeRouterCubit>()
              .navigateTo(const EditOrderPageState());
          context.read<EditOrderCubit>().getOrder(order);
        },
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
            title: listTileTitle(order),
            subtitle: listTileSubtitle(order, orderPrice),
            trailing: listTileTrailing(order, orderDate)),
      ),
    );
  }
}
