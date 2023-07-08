import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_cubit.dart';
import 'package:moxy/domain/models/order.dart';

import '../../../../../services/navigation/admin_home_router_cubit.dart';
import '../../../../components/snackbar_widgets.dart';
import '../../../../../domain/admin/all_orders/all_orders_cubit.dart';
import '../../../../../domain/admin/all_orders/all_orders_state.dart';
import '../../../../theme/app_theme.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isFilterChipsVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
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
      return Scaffold(
          body: Material(
        color: AppTheme.pink,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppTheme.pink,
              surfaceTintColor: AppTheme.pink,
              floating: true,
              pinned: false,
              snap: true,
              toolbarHeight: showTopBar ? 75 : 0.0,
              title: showTopBar
                  ? Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceAround,
                      children: _filterChipsList(context, cubit, state),
                    )
                  : null,
            ),
            SliverToBoxAdapter(
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: state.allOrders.isEmpty
                          ? const Text('No orders')
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.allOrders.length,
                              itemBuilder: (BuildContext context, int index) {
                                final order = state.allOrders[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.all(14.0),
                                    onTap: () {
                                      context
                                          .read<AdminHomeRouterCubit>()
                                          .navigateTo(
                                              const EditOrderPageState());
                                      context
                                          .read<EditOrderCubit>()
                                          .getOrder(order);
                                    },
                                    tileColor: AppTheme.white,
                                    leading: ClipOval(
                                        child: _buildImage(order.orderedItems)),
                                    title: Text(
                                        '${order.client.firstName} ${order.client.secondName}'),
                                    subtitle: Text(
                                        order.orderedItems.first.productName),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                );
                              }),
                    ),
            ),
          ],
        ),
      ));
    });
  }

  Widget _buildImage(List<OrderedItem> products) {
    if (products.isEmpty || products.first.imageUrl == null) {
      return Image.asset(
        width: 50,
        height: 50,
        'assets/images/placeholder.jpg',
        fit: BoxFit.cover,
      );
    } else {
      return FadeInImage.assetNetwork(
        placeholder: 'assets/images/placeholder.jpg',
        image: products.first.imageUrl!,
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
            label: Text(state.deliveryFilter.name.toString()),
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
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: FilterChip(
            avatar: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.close,
              ),
            ),
            label: Text(state.paymentFilter.name.toString()),
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
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: FilterChip(
            avatar: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.close,
              ),
            ),
            label: Text(state.statusFilter.toString()),
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
      chipsList.add(
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: FilterChip(
            avatar: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.close,
              ),
            ),
            label: Text(state.dateRangeFilter.toString()),
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
}
