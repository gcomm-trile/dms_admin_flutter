/// Package import
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'chart_sample_data.dart';

/// Renders the stacked column chart sample.
class StackedColumnChart extends StatefulWidget {
  final List<ChartSampleData> chartData;
  final List<String> columns;
  final String title;
  final Color colorColumn;

  /// Creates the stacked column chart sample.
  const StackedColumnChart(
      {Key key,
      @required this.title,
      @required this.colorColumn,
      @required this.chartData,
      @required this.columns})
      : super(key: key);

  @override
  _StackedColumnChartState createState() => _StackedColumnChartState();
}

/// State class of the stacked column chart.
class _StackedColumnChartState extends State<StackedColumnChart> {
  _StackedColumnChartState();

  @override
  Widget build(BuildContext context) {
    return _getStackedColumnChart();
  }

  /// Returns the cartesian Stacked column chart.
  SfCartesianChart _getStackedColumnChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: widget.title),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          axisLine: AxisLine(width: 0),
          labelFormat: '{value}',
          maximum: 30,
          majorTickLines: MajorTickLines(size: 0)),
      series: _getStackedColumnSeries(),
      tooltipBehavior:
          TooltipBehavior(enable: true, header: '', canShowMarker: false),
    );
  }

  /// Returns the list of chart serie which need to render
  /// on the stacked column chart.
  List<StackedColumnSeries<ChartSampleData, String>> _getStackedColumnSeries() {
    var result = <StackedColumnSeries<ChartSampleData, String>>[];

    if (widget.columns.length > 0) {
      result.add(StackedColumnSeries<ChartSampleData, String>(
          dataSource: widget.chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: widget.columns[0]));
    }
    if (widget.columns.length > 1) {
      result.add(StackedColumnSeries<ChartSampleData, String>(
          dataSource: widget.chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          name: widget.columns[1]));
    }
    if (widget.columns.length > 2) {
      result.add(StackedColumnSeries<ChartSampleData, String>(
          dataSource: widget.chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: widget.columns[2]));
    }
    if (widget.columns.length > 3) {
      result.add(StackedColumnSeries<ChartSampleData, String>(
          dataSource: widget.chartData,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
          name: widget.columns[3]));
    }
    return result;
  }
}
