import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  Chart({Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final List<ChartData> dataSourceList = [
    ChartData('Jan', 1000, 800),
    ChartData('Feb', 1234, 1100),
    ChartData('Mar', 2342, 2000),
    ChartData('Apr', 3453, 3000),
    ChartData('May', 2321, 2000),
  ];
  int? selectedColumnIndex1;
  int? selectedColumnIndex2;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  'Activity',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ),
              SfCartesianChart(
                primaryYAxis: NumericAxis(
                  majorGridLines: const MajorGridLines(
                    width: 1,
                    dashArray: <double>[5, 5],
                  ),
                  interval: 1000,
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
                palette: const <Color>[
                  AppTheme.violet,
                  AppTheme.pinkDark,
                ],
                series: <ChartSeries>[
                  ColumnSeries<ChartData, String>(
                      onPointTap: (args) {
                        setState(() {
                          selectedColumnIndex1 = args.pointIndex;
                          selectedColumnIndex2 = null;
                        });
                      },
                      dataSource: dataSourceList,
                      markerSettings: MarkerSettings(
                          isVisible:
                              selectedColumnIndex2 != null ? false : true),
                      dataLabelSettings: DataLabelSettings(
                          isVisible:
                              selectedColumnIndex2 != null ? false : true,
                          textStyle: const TextStyle(fontSize: 0)),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y2,
                      width: 0.4,
                      spacing: 0.1,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12))),
                  ColumnSeries<ChartData, String>(
                      onPointTap: (args) {
                        setState(() {
                          selectedColumnIndex2 = args.pointIndex;
                          selectedColumnIndex1 = null;
                        });
                      },
                      dataSource: dataSourceList,
                      markerSettings: MarkerSettings(
                          isVisible:
                              selectedColumnIndex1 != null ? false : true),
                      dataLabelSettings: DataLabelSettings(
                          isVisible:
                              selectedColumnIndex1 != null ? false : true,
                          textStyle: const TextStyle(fontSize: 0)),
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      width: 0.4,
                      spacing: 0.1,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12))),
                ],
                onDataLabelRender: (DataLabelRenderArgs args) {
                  final int pointIndex = args.pointIndex!;
                  if (pointIndex == selectedColumnIndex1 ||
                      pointIndex == selectedColumnIndex2) {
                    args.text = '\$ ${args.text}';
                    args.color = AppTheme.black;
                    args.textStyle = const TextStyle(fontSize: 14);
                  }
                },
                onMarkerRender: (markerArgs) {
                  final int pointIndex = markerArgs.pointIndex!;
                  if (pointIndex == selectedColumnIndex1 ||
                      pointIndex == selectedColumnIndex2) {
                    markerArgs.color = AppTheme.black;
                    markerArgs.markerHeight = 12;
                    markerArgs.markerWidth = 12;
                  } else {
                    markerArgs.markerHeight = 0;
                    markerArgs.markerWidth = 0;
                  }
                },
              ),
            ]),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y2);
  final String x;
  final double? y;
  final double? y2;
}
