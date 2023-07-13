import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../constant/icon_path.dart';
import '../../../../../domain/admin/dashboard/dashboard_cubit.dart';
import '../../../../../domain/admin/dashboard/dashboard_state.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Material(
              color: AppTheme.pink,
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(children: [
                      totalBalance(state.totalBalance),
                      const SizedBox(
                        height: 20,
                      ),
                      totalProduct(state.totalProduct),
                      const SizedBox(
                        height: 20,
                      ),
                      earning(context),
                      const SizedBox(
                        height: 20,
                      ),
                      chart()
                    ])),
              )),
        );
      },
    );
  }
}

totalBalance(totalBalance) {
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
              const Text('Total Balance',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              Text(
                '\$ ${totalBalance.toString()}',
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

totalProduct(totalProduct) {
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
              const Text('Total Product',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${totalProduct}',
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

earning(context) {
  return Container(
    child: Row(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: AppTheme.green,
                        radius: 5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Earning',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$ 23.343',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'from last mo',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.gray),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: AppTheme.darkPink,
                        radius: 5,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Earning',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: AppTheme.gray),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$ 23.343',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'from last weak',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: AppTheme.gray),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

chart() {
  // var index;

  return Container(
      decoration: const BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SfCartesianChart(
            // onDataLabelRender: (DataLabelRenderArgs args) {
            //   if (index != null && index == args.pointIndex) {
            //     args.textStyle = TextStyle(fontSize: 14, color: AppTheme.black);
            //   }
            // },
            primaryYAxis: NumericAxis(
              majorGridLines: const MajorGridLines(
                width: 1,
                dashArray: <double>[5, 5],
              ),
              axisLabelFormatter: (axisLabelRenderArgs) {
                final int value = axisLabelRenderArgs.value.toInt();
                if (value >= 1000) {
                  return ChartAxisLabel(
                      '\$${(value / 1000).toStringAsFixed(0)}k',
                      const TextStyle(color: AppTheme.gray));
                } else {
                  return ChartAxisLabel(
                      '\$$value', const TextStyle(color: AppTheme.gray));
                }
              },
            ),
            primaryXAxis: CategoryAxis(
              labelStyle: const TextStyle(color: AppTheme.gray),
              majorGridLines: const MajorGridLines(width: 0),
            ),
            palette: <Color>[
              AppTheme.violet,
              AppTheme.pinkDark,
            ],
            series: <ChartSeries>[
              ColumnSeries<ChartData, String>(
                  dataSource: [
                    ChartData('Jan', 1000, 800),
                    ChartData('Feb', 1234, 1100),
                    ChartData('Mar', 2342, 2000),
                    ChartData('Apr', 3453, 3000),
                    ChartData('May', 2321, 2000),
                  ],
                  dataLabelSettings: const DataLabelSettings(
                      isVisible: true, textStyle: TextStyle(fontSize: 0)),
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y2,
                  width: 0.4,
                  // onPointTap: (pointInteractionDetails) {
                  //   index = pointInteractionDetails.pointIndex!;
                  //   moxyPrint(index);
                  // },
                  spacing: 0.1,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12))),
              ColumnSeries<ChartData, String>(
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true, textStyle: TextStyle(fontSize: 0)),
                  dataSource: [
                    ChartData('Jan', 1000, 800),
                    ChartData('Feb', 1234, 1100),
                    ChartData('Mar', 2342, 2000),
                    ChartData('Apr', 3453, 3000),
                    ChartData('May', 2321, 2000),
                  ],
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  width: 0.4,
                  // onPointTap: (pointInteractionDetails) {
                  //   index = pointInteractionDetails.pointIndex!;
                  //   moxyPrint(index);
                  // },
                  spacing: 0.1,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12))),
            ]),
      ));
}

class ChartData {
  ChartData(this.x, this.y, this.y2);
  final String x;
  final double? y;
  final double? y2;
}
