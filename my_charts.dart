import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

typedef TDatum = MyPoint; // <T>
typedef TDomain = DateTime; // <D>

class MyPoint {
  final TDomain x;
  final int y;
  MyPoint([DateTime? x, this.y = 0]) : this.x = x ?? DateTime.now();
}

List<TDatum> generateData() {
  return [
    for (int i = 0; i < 12; i++) MyPoint(DateUtils.addMonthsToMonthDate(DateTime.now(), -12 + i), i * i),
  ];
}

charts.Series<TDatum, TDomain> generateSeries() {
  return charts.Series<TDatum, TDomain>(
    id: 'My series ID',
    data: generateData(),
    domainFn: ((TDatum datum, int? index) => datum.x) as TDomain Function(TDatum, int?),
    measureFn: ((TDatum datum, int? index) => datum.y) as num? Function(TDatum, int?),
  );
}

charts.BaseChart<TDomain> generateChart() {
  return charts.TimeSeriesChart(
    [
      generateSeries(),
    ],
    defaultRenderer: charts.LineRendererConfig(
      includeArea: true,
      stacked: true,
      includePoints: true,
      includeLine: true,
    ),
    domainAxis: charts.DateTimeAxisSpec(
      tickFormatterSpec: charts.BasicDateTimeTickFormatterSpec.fromDateFormat(intl.DateFormat('MMM')),
    ),
    layoutConfig: charts.LayoutConfig(
      leftMarginSpec: charts.MarginSpec.defaultSpec,
      rightMarginSpec: charts.MarginSpec.defaultSpec,
      topMarginSpec: charts.MarginSpec.defaultSpec,
      bottomMarginSpec: charts.MarginSpec.defaultSpec
    ),
  );
}

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return generateChart();
  }
}
