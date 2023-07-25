import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../../constant/icon_path.dart';
import '../../../../../domain/admin/dashboard/dashboard_cubit.dart';
import '../../../../../domain/admin/dashboard/dashboard_state.dart';
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
                            opacity: state.selectedDate != null ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            child: AnimatedSize(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut,
                              child: state.selectedDate != null
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'Date Range: ${state.selectedDate?.start.toString().split(' ')[0]} - ${state.selectedDate?.end.toString().split(' ')[0]}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: AppTheme.gray),
                                            ),
                                          )
                                        ])
                                  : Container(),
                            ),
                          ),
                          totalSale(state.totalSale),
                          const SizedBox(
                            height: 10,
                          ),
                          totalCost(state.totalCost),
                          const SizedBox(
                            height: 10,
                          ),
                          totalOrdersCount(state.totalOrders),
                          const SizedBox(
                            height: 10,
                          ),
                          Chart()
                        ])),
            ),
          ),
        );
      },
    );
  }
}

totalSale(totalSale) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: AppTheme.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
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
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Sale',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$ ${totalSale}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

totalCost(totalCost) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: AppTheme.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
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
                width: 30,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Cost ',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$ ${totalCost}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

totalOrdersCount(totalOrdersCount) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      color: AppTheme.white,
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
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
                width: 30,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Total Orders Count',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              Text(
                totalOrdersCount.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
