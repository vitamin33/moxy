import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../constant/icon_path.dart';
import '../../../../../domain/admin/dashboard/dashboard_cubit.dart';
import '../../../../../domain/admin/dashboard/dashboard_state.dart';
import '../../../../components/orders_chart.dart';
import '../../../../components/overview_chart.dart';

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
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: state.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(children: [
                          AnimatedOpacity(
                            opacity: state.selectedDate != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 800),
                            child: AnimatedSize(
                              duration: const Duration(milliseconds: 800),
                              curve: Curves.easeInOut,
                              child: state.selectedDate != null
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
                            ),
                          ),
                          total(context, state),
                          const SizedBox(
                            height: 10,
                          ),
                          AnimatedOpacity(
                            opacity: state.selectedDate != null ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 800),
                            child: state.selectedDate != null
                                ? AnimatedSize(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.easeInOut,
                                    child: state.selectedDate != null
                                        ? Column(
                                            children: [
                                              const Text(
                                                'Previous Same Period',
                                                style: TextStyle(
                                                    color: AppTheme.pinkDark,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                        : Container())
                                : Container(),
                          ),
                          Chart(
                              saleFromTimeFrame: state.saleFromTimeFrame,
                              costFromTimeFrame: state.costFromTimeFrame),
                          const SizedBox(
                            height: 10,
                          ),
                          OrdersChart(
                              ordersFromTimeFrame: state.ordersFromTimeFrame)
                        ])),
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
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppTheme.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppTheme.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          IconPath.wallet,
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Sale',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$ ${state.totalSale.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppTheme.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppTheme.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          IconPath.cashPayment,
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Cost',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$ ${state.totalCost.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppTheme.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppTheme.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          IconPath.orders,
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Orders',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.totalOrders}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

previusTotal(context, DashboardState state) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppTheme.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppTheme.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          IconPath.wallet,
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Sale',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$ ${state.previousTotalSaleValue.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(state.saleValuePercentageChange > 0
                        ? IconPath.rightUpArrow
                        : IconPath.rightDownArrow),
                    Expanded(
                      child: Text(
                          ' ${state.saleValuePercentageChange.toInt()} % from  peroid',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: state.saleValuePercentageChange > 0
                                  ? AppTheme.greenDark
                                  : AppTheme.red)),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 10,
      ),
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppTheme.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppTheme.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          IconPath.cashPayment,
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Cost',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '\$ ${state.previousTotalCostValue.toString()}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(state.costValuePercentageChange > 0
                        ? IconPath.rightUpArrow
                        : IconPath.rightDownArrow),
                    Expanded(
                      child: Text(
                          ' ${state.costValuePercentageChange.toInt()} % from peroid',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: state.costValuePercentageChange > 0
                                  ? AppTheme.greenDark
                                  : AppTheme.red)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppTheme.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppTheme.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          IconPath.orders,
                          color: Colors.white,
                          width: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Orders',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.gray),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${state.previousTotalOrdersCount}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    SvgPicture.asset(state.ordersCountPercentageChange > 0
                        ? IconPath.rightUpArrow
                        : IconPath.rightDownArrow),
                    Expanded(
                      child: Text(
                        ' ${state.ordersCountPercentageChange.toInt()} % from peroid ',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: state.ordersCountPercentageChange > 0
                                ? AppTheme.greenDark
                                : AppTheme.red),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
