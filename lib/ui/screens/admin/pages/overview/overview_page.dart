import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../constant/icon_path.dart';
import '../../../../../domain/admin/dashboard/dashboard_cubit.dart';
import '../../../../../domain/admin/dashboard/dashboard_state.dart';
import '../../../../components/current_stat_value.dart';
import '../../../../components/orders_chart.dart';
import '../../../../components/overview_chart.dart';
import '../../../../components/previus_stat_value.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: AppTheme.pink,
            child: ListView(
              children: [
                state.isLoading
                    ? const LinearProgressIndicator(
                        color: AppTheme.pinkDark,
                        backgroundColor: AppTheme.pink,
                      )
                    : Container(),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 800),
                  opacity: state.animated == true ? 1.0 : 0.0,
                  child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(children: [
                          state.selectedDate != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Selected Date: ${state.selectedDate?.start.toString().split(' ')[0]} - ${state.selectedDate?.end.toString().split(' ')[0]}',
                                          style: const TextStyle(
                                              color: AppTheme.pinkDark,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )
                                    ])
                              : Container(),
                          total(context, state),
                          const SizedBox(
                            height: 10,
                          ),
                          state.selectedDate != null
                              ? Column(
                                  children: [
                                    const Text(
                                      'Previous Same Period',
                                      style: TextStyle(
                                          color: AppTheme.pinkDark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Divider(
                                      color: AppTheme.pinkDark,
                                    ),
                                    previusTotal(context, state),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              : Container(),
                          state.isLoading != true
                              ? Column(
                                  children: [
                                    Chart(
                                        saleFromTimeFrame:
                                            state.saleFromTimeFrame,
                                        costFromTimeFrame:
                                            state.costFromTimeFrame),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    OrdersChart(
                                        ordersFromTimeFrame:
                                            state.ordersFromTimeFrame)
                                  ],
                                )
                              : Container(),
                        ])),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

total(context, DashboardState state) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      CurrentStatValue(
        value: state.totalSale.toString(),
        iconPath: IconPath.wallet,
        title: 'Sale',
      ),
      const SizedBox(
        width: 10,
      ),
      CurrentStatValue(
        value: state.totalCost.toString(),
        iconPath: IconPath.cashPayment,
        title: 'Cost',
      ),
      const SizedBox(
        width: 10,
      ),
      CurrentStatValue(
        value: state.totalOrders.toString(),
        iconPath: IconPath.orders,
        title: 'Orders',
      ),
    ],
  );
}

previusTotal(context, DashboardState state) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      PreviusStatValue(
        value: state.totalSale.toString(),
        iconPath: IconPath.wallet,
        title: 'Sale',
        percentageValue: state.saleValuePercentageChange,
      ),
      const SizedBox(
        width: 10,
      ),
      PreviusStatValue(
          value: state.totalCost.toString(),
          iconPath: IconPath.cashPayment,
          title: 'Cost',
          percentageValue: state.costValuePercentageChange),
      const SizedBox(
        width: 10,
      ),
      PreviusStatValue(
          value: state.totalOrders.toString(),
          iconPath: IconPath.orders,
          title: 'Orders',
          percentageValue: state.ordersCountPercentageChange),
    ],
  );
}
