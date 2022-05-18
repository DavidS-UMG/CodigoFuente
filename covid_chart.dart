// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'data_entry.dart';
import 'hard_data.dart';

typedef TDatum = DataEntry; // <T>
typedef TDomain = DateTime; // <D>

bool mexico = true;
bool cases = true;
bool zoom = true;

List<charts.Series<TDatum, TDomain>> generateSeries() {
  List<TDatum> data = (mexico ? mexicoData : worldData);
  if (zoom) data = data.where((e) => e.dateReported.isAfter(DateTime.now().subtract(Duration(days: 365)))).toList();
  return [
    charts.Series<TDatum, TDomain>(
      id: cases ? 'Casos totales' : 'Muertes totales',
      data: data,
      domainFn: ((TDatum datum, int? index) => datum.dateReported),
      measureFn: ((TDatum datum, int? index) => cases ? datum.cumulativeCases : datum.cumulativeDeaths),
      colorFn: (_, __) => cases ? charts.MaterialPalette.blue.shadeDefault : charts.MaterialPalette.purple.shadeDefault,
    ),
    charts.Series<TDatum, TDomain>(
      id: cases ? 'Nuevos casos' : 'Nuevas muertes',
      data: data,
      domainFn: ((TDatum datum, int? index) => datum.dateReported),
      measureFn: ((TDatum datum, int? index) => cases ? datum.newCases : datum.newDeaths),
      colorFn: (_, __) =>
          cases ? charts.MaterialPalette.green.shadeDefault : charts.MaterialPalette.red.shadeDefault,
    ),
  ];
}

charts.BaseChart<TDomain> generateChart() {
  return charts.TimeSeriesChart(
    [
      ...generateSeries(),
    ],
    defaultRenderer: charts.LineRendererConfig(
      includeArea: true,
      includePoints: true,
      includeLine: true,
    ),
    layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.defaultSpec,
        rightMarginSpec: charts.MarginSpec.defaultSpec,
        topMarginSpec: charts.MarginSpec.defaultSpec,
        bottomMarginSpec: charts.MarginSpec.defaultSpec),
    behaviors: [
      charts.ChartTitle('COVID-19 en ${mexico ? 'México' : 'el Mundo'}'),
      charts.SeriesLegend(),
      charts.LinePointHighlighter(showHorizontalFollowLine: charts.LinePointHighlighterFollowLineType.nearest),
    ],
  );
}

class MyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return generateChart();
  }
}
