import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/response/dashboard_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrdersChart extends StatefulWidget {
  final List<TotalByTimeFrame> ordersFromTimeFrame;

  const OrdersChart({super.key, required this.ordersFromTimeFrame});

  @override
  // ignore: library_private_types_in_public_api
  _OrdersChartState createState() => _OrdersChartState();
}

class _OrdersChartState extends State<OrdersChart> {
  List<OrdersChartData> dataSourceList = [];
  @override
  void initState() {
    super.initState();
    updateDataSourceList();
  }

  void updateDataSourceList() {
    dataSourceList.clear();
    for (int i = 0; i < widget.ordersFromTimeFrame.length; i++) {
      String formattedDate = '';
      //Chek if the key is the date
      if (widget.ordersFromTimeFrame[i].key.length > 4) {
        DateTime dateTime =
            DateTime.parse(widget.ordersFromTimeFrame[i].key.toString());
        formattedDate = DateFormat("dd/MM").format(dateTime);
      } else {
        formattedDate = widget.ordersFromTimeFrame[i].key;
      }
      double ordersValue = widget.ordersFromTimeFrame[i].value.toDouble();
      dataSourceList.add(
        OrdersChartData(
          formattedDate,
          ordersValue,
        ),
      );
    }
  }

  int? selectedColumnIndex1;
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
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
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  AppLocalizations.of(context)!.overviewOrders,
                  style: theme.headlineSemiBoltText,
                ),
              ),
              SfCartesianChart(
                primaryYAxis: NumericAxis(
                  majorGridLines: const MajorGridLines(
                    width: 1,
                    dashArray: <double>[5, 5],
                  ),
                  interval: 1,
                  axisLabelFormatter: (axisLabelRenderArgs) {
                    return ChartAxisLabel(axisLabelRenderArgs.text,
                        theme.mediumText.copyWith(color: AppTheme.gray));
                  },
                ),
                primaryXAxis: CategoryAxis(
                  labelStyle: theme.mediumText.copyWith(color: AppTheme.gray),
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                palette: const <Color>[
                  AppTheme.pinkDark,
                ],
                series: <ChartSeries>[
                  ColumnSeries<OrdersChartData, String>(
                      onPointTap: (args) {
                        setState(() {
                          if (selectedColumnIndex1 == args.pointIndex) {
                            selectedColumnIndex1 = null;
                          } else {
                            selectedColumnIndex1 = args.pointIndex;
                          }
                        });
                      },
                      dataSource: dataSourceList,
                      markerSettings: const MarkerSettings(
                          isVisible: true,
                          height: 12,
                          width: 12,
                          color: AppTheme.black),
                      dataLabelSettings:  DataLabelSettings(
                          isVisible: true,
                          textStyle: theme.largeText,
                          color: AppTheme.black),
                      xValueMapper: (OrdersChartData data, _) => data.x,
                      yValueMapper: (OrdersChartData data, _) => data.y,
                      width: 0.2,
                      spacing: 0.1,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12))),
                ],
                onDataLabelRender: (DataLabelRenderArgs args) {
                  final int pointIndex = args.pointIndex!;
                  if (pointIndex != selectedColumnIndex1) {
                    args.text = '';
                  }
                },
                onMarkerRender: (markerArgs) {
                  final int pointIndex = markerArgs.pointIndex!;
                  if (pointIndex != selectedColumnIndex1) {
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

class OrdersChartData {
  OrdersChartData(this.x, this.y);
  final String x;
  final double? y;
}
