import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/response/dashboard_response.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Chart extends StatefulWidget {
  final List<TotalByTimeFrame> saleFromTimeFrame;
  final List<TotalByTimeFrame> costFromTimeFrame;
  final List<TotalByTimeFrame> profitFromTimeFrame;

  const Chart({
    super.key,
    required this.saleFromTimeFrame,
    required this.costFromTimeFrame,
    required this.profitFromTimeFrame,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<ChartData> dataSourceList = [];
  @override
  void initState() {
    super.initState();
    updateDataSourceList();
  }

  void updateDataSourceList() {
    dataSourceList.clear();
    for (int i = 0; i < widget.saleFromTimeFrame.length; i++) {
      String formattedDate = '';
      //Chek if the key is the date
      if (widget.saleFromTimeFrame[i].key.length > 4) {
        DateTime dateTime =
            DateTime.parse(widget.saleFromTimeFrame[i].key.toString());
        formattedDate = DateFormat("dd/MM").format(dateTime);
      } else {
        formattedDate = widget.saleFromTimeFrame[i].key;
      }
      double saleValue = widget.saleFromTimeFrame[i].value.toDouble();
      double costValue = widget.costFromTimeFrame[i].value.toDouble();
      double profitValue = widget.profitFromTimeFrame[i].value.toDouble();
      dataSourceList.add(
        ChartData(
          formattedDate,
          saleValue,
          costValue,
          profitValue,
        ),
      );
    }
  }

  int? selectedColumnIndex1;
  int? selectedColumnIndex2;
  int? selectedColumnIndex3;
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
                child: Text(AppLocalizations.of(context)!.overviewChartTitle,
                    style: theme.largeSemiBoltText),
              ),
              SfCartesianChart(
                legend: const Legend(
                    isVisible: true, position: LegendPosition.bottom),
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
                          '₴${(value / 1000).toStringAsFixed(0)}k',
                          theme.mediumText.copyWith(color: AppTheme.gray));
                    } else {
                      return ChartAxisLabel('₴$value',
                          theme.mediumText.copyWith(color: AppTheme.gray));
                    }
                  },
                ),
                primaryXAxis: CategoryAxis(
                  labelStyle: theme.mediumText.copyWith(color: AppTheme.gray),
                  majorGridLines: const MajorGridLines(width: 0),
                ),
                palette: const <Color>[
                  AppTheme.violet,
                  AppTheme.pinkAvarage,
                  AppTheme.pinkDark,
                ],
                series: <CartesianSeries>[
                  ColumnSeries<ChartData, String>(
                    onPointTap: (args) {
                      setState(() {
                        selectedColumnIndex1 = args.pointIndex;
                        selectedColumnIndex2 = null;
                        selectedColumnIndex3 = null;
                      });
                    },
                    name: AppLocalizations.of(context)!.overviewTotalCost,
                    dataSource: dataSourceList,
                    markerSettings: MarkerSettings(
                        isVisible: (selectedColumnIndex2 != null ||
                                selectedColumnIndex3 != null)
                            ? false
                            : true),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: (selectedColumnIndex2 != null ||
                                selectedColumnIndex3 != null)
                            ? false
                            : true,
                        textStyle: theme.invisibleText),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y2,
                    width: 0.4,
                    spacing: 0.1,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  ColumnSeries<ChartData, String>(
                    onPointTap: (args) {
                      setState(() {
                        selectedColumnIndex2 = args.pointIndex;
                        selectedColumnIndex1 = null;
                        selectedColumnIndex3 = null;
                      });
                    },
                    name: AppLocalizations.of(context)!.overviewTotalSale,
                    dataSource: dataSourceList,
                    markerSettings: MarkerSettings(
                        isVisible: (selectedColumnIndex1 != null ||
                                selectedColumnIndex3 != null)
                            ? false
                            : true),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: (selectedColumnIndex1 != null ||
                                selectedColumnIndex3 != null)
                            ? false
                            : true,
                        textStyle: theme.invisibleText),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    width: 0.4,
                    spacing: 0.1,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  ColumnSeries<ChartData, String>(
                    onPointTap: (args) {
                      setState(() {
                        selectedColumnIndex3 = args.pointIndex;
                        selectedColumnIndex1 = null;
                        selectedColumnIndex2 = null;
                      });
                    },
                    name: AppLocalizations.of(context)!.overviewTotalProfit,
                    dataSource: dataSourceList,
                    markerSettings: MarkerSettings(
                        isVisible: (selectedColumnIndex1 != null ||
                                selectedColumnIndex2 != null)
                            ? false
                            : true),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: (selectedColumnIndex1 != null ||
                                selectedColumnIndex2 != null)
                            ? false
                            : true,
                        textStyle: theme.invisibleText),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y3,
                    width: 0.4,
                    spacing: 0.1,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                ],
                onDataLabelRender: (DataLabelRenderArgs args) {
                  final int pointIndex = args.pointIndex!;
                  if (pointIndex == selectedColumnIndex1 ||
                      pointIndex == selectedColumnIndex2 ||
                      pointIndex == selectedColumnIndex3) {
                    args.text = '₴ ${args.text}';
                    args.color = AppTheme.black;
                    args.textStyle =
                        theme.mediumText.copyWith(color: AppTheme.gray);
                  }
                },
                onMarkerRender: (markerArgs) {
                  final int pointIndex = markerArgs.pointIndex!;
                  if (pointIndex == selectedColumnIndex1 ||
                      pointIndex == selectedColumnIndex2 ||
                      pointIndex == selectedColumnIndex3) {
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
  ChartData(this.x, this.y, this.y2, this.y3);
  final String x;
  final double? y;
  final double? y2;
  final double? y3;
}
