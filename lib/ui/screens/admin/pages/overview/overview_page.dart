import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../constant/icon_path.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
          color: AppTheme.pink,
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  totalBalance(),
                  const SizedBox(
                    height: 20,
                  ),
                  totalProduct(),
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
  }
}

totalBalance() {
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
            children: const [
              Text('Total Balance',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 5,
              ),
              Text(
                '\$ 41,210',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

totalProduct() {
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
            children: const [
              Text('Total Product',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.gray,
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 5,
              ),
              Text(
                '210',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
        SizedBox(
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
  return Container(
      color: AppTheme.white,
      child:
          SfCartesianChart(primaryXAxis: CategoryAxis(), series: <ChartSeries>[
        // Initialize line series
        LineSeries<ChartData, String>(
            dataSource: [
              // Bind data source
              ChartData('Jan', 35),
              ChartData('Feb', 28),
              ChartData('Mar', 34),
              ChartData('Apr', 32),
              ChartData('May', 40)
            ],
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ]));
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double? y;
}
