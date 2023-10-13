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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                        selectedDateTextWidget(state, context),
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
                                          state.costFromTimeFrame,
                                      profitFromTimeFrame:
                                          state.profitFromTimeFrame,
                                    ),
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

  Widget selectedDateTextWidget(DashboardState state, context) {
    return state.selectedDate != null
        ? AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: state.isLoading
                ? Container()
                : Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${AppLocalizations.of(context)!.overviewSelectedDate} ${state.selectedDate?.start.toString().split(' ')[0]} - ${state.selectedDate?.end.toString().split(' ')[0]}',
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            AppLocalizations.of(context)!.overviewPreviusPeriod,
                            style: const TextStyle(
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

  Widget totalSelectedDataWidget(context, DashboardState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: CurrentStatValue(
                value: state.totalSale.toString(),
                iconPath: IconPath.wallet,
                title: AppLocalizations.of(context)!.overviewSale,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CurrentStatValue(
                value: state.totalCost.toString(),
                iconPath: IconPath.cashPayment,
                title: AppLocalizations.of(context)!.overviewCost,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: CurrentStatValue(
                value: state.totalProfit.toString(),
                iconPath: IconPath.wallet,
                title: AppLocalizations.of(context)!.overviewProfit,
                showCurrency: true,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: CurrentStatValue(
                value: state.totalOrders.toString(),
                iconPath: IconPath.orders,
                title: AppLocalizations.of(context)!.overviewOrders,
                showCurrency: false,
              ),
            ),
          ],
        )
      ],
    );
  }

  previusTotal(context, DashboardState state) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: PreviusStatValue(
                value: state.previousTotalSaleValue.toString(),
                iconPath: IconPath.wallet,
                title: AppLocalizations.of(context)!.overviewSale,
                percentageValue: state.saleValuePercentageChange,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: PreviusStatValue(
                value: state.previousTotalCostValue.toString(),
                iconPath: IconPath.cashPayment,
                title: AppLocalizations.of(context)!.overviewCost,
                percentageValue: state.costValuePercentageChange,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: PreviusStatValue(
                value: state.previousTotalProfit.toString(),
                iconPath: IconPath.wallet,
                title: AppLocalizations.of(context)!.overviewProfit,
                percentageValue: state.profitPercentageChange,
                showCurrency: true,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: PreviusStatValue(
                value: state.previousTotalOrdersCount.toString(),
                iconPath: IconPath.orders,
                title: AppLocalizations.of(context)!.overviewOrders,
                percentageValue: state.ordersCountPercentageChange,
                showCurrency: false,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
