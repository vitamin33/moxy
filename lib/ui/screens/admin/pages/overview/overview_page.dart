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
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        selectedDateTextWidget(state),
                        totalSelectedDataWidget(context, state),
                        const SizedBox(
                          height: 10,
                        ),
                        previousPeriodDataWidget(context, state),
                        AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          child: state.isLoading
                              ? Container()
                              : Column(
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
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget selectedDateTextWidget(DashboardState state) {
    return state.selectedDate != null
        ? AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: state.isLoading
                ? Container()
                : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Selected Date: ${state.selectedDate?.start.toString().split(' ')[0]} - ${state.selectedDate?.end.toString().split(' ')[0]}',
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    )
                  ]),
          )
        : Container();
  }

  Widget previousPeriodDataWidget(BuildContext context, DashboardState state) {
    return state.selectedDate != null
        ? AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: state.isLoading
                ? Container()
                : Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Previous Same Period',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      previusTotal(context, state),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
          )
        : Container();
  }
}

Widget totalSelectedDataWidget(context, DashboardState state) {
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
        showCurrency: false,
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
        value: state.previousTotalSaleValue.toString(),
        iconPath: IconPath.wallet,
        title: 'Sale',
        percentageValue: state.saleValuePercentageChange,
      ),
      const SizedBox(
        width: 10,
      ),
      PreviusStatValue(
        value: state.previousTotalCostValue.toString(),
        iconPath: IconPath.cashPayment,
        title: 'Cost',
        percentageValue: state.costValuePercentageChange,
      ),
      const SizedBox(
        width: 10,
      ),
      PreviusStatValue(
        value: state.previousTotalOrdersCount.toString(),
        iconPath: IconPath.orders,
        title: 'Orders',
        percentageValue: state.ordersCountPercentageChange,
        showCurrency: false,
      ),
    ],
  );
}
