import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_sample_data.dart';
import 'custom_directional_buttons.dart';

class ColumnSpacing extends StatefulWidget {
  /// Creates the column chart with columns width and space change option
  const ColumnSpacing({Key key}) : super(key: key);

  @override
  _ColumnSpacingState createState() => _ColumnSpacingState();
}

class _ColumnSpacingState extends State {
  dynamic chart;
  bool isDrilledChart = false;
  TooltipBehavior _tooltipBehavior;
  double _columnWidth = 0.95;
  double _columnSpacing = 0.05;
  Color textColor = Colors.red;
  bool isCardView = true;
  int level = 1;
  _ColumnSpacingState();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: false);

    _columnWidth = 0.95;
    _columnSpacing = 0.05;
    chart = getLevel1Chart();
    super.initState();
  }

  getChart() {
    switch (level) {
      case 1:
        return getLevel1Chart();
      case 2:
        return getLevel2Chart(0);
      case 3:
        return getLevel3Char(0, 0);

      default:
        return Container(
          color: Colors.red,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('level ' + level.toString());
    return Stack(
      children: <Widget>[
        getChart(),
        Positioned(
          left: 10,
          top: 5,
          child: Visibility(
            visible: level > 1,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  if (level > 1) level--;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  SfCartesianChart getLevel1Chart() {
    return chart = SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Báo cáo khu vực'),
      onPointTapped: (PointTapArgs args) {
        setState(() {
          level = 2;
        });
      },
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          maximum: 150,
          minimum: 0,
          interval: 25,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getLevel1Column(),
      legend: Legend(isVisible: true),
    );
  }

  getLevel2Chart(num index) {
    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Báo cáo tuyến'),
      onPointTapped: (PointTapArgs args) {
        setState(() {
          level = 3;
        });
      },
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          maximum: 150,
          minimum: 0,
          interval: 25,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getLevel2Column(),
      legend: Legend(isVisible: true),
    );
  }

  getLevel3Char(int i, int j) {
    return chart = SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Báo cáo nhân viên'),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          maximum: 150,
          minimum: 0,
          interval: 25,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getLevel3Column(),
      legend: Legend(isVisible: true),
    );
  }

  ///Get the cartesian chart widget

  List<ColumnSeries<ChartSampleData, String>> _getLevel1Column() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'HỒ CHÍ MINH',
          y: 128,
          secondSeriesYValue: 129,
          thirdSeriesYValue: 101),
      ChartSampleData(
          x: 'HÀ NỘI', y: 123, secondSeriesYValue: 92, thirdSeriesYValue: 93),
      ChartSampleData(
          x: 'ĐÀ NẴNG', y: 107, secondSeriesYValue: 106, thirdSeriesYValue: 90),
      ChartSampleData(
          x: 'CẦN THƠ', y: 87, secondSeriesYValue: 95, thirdSeriesYValue: 71),
      ChartSampleData(
          x: 'BÌNH DƯƠNG',
          y: 87,
          secondSeriesYValue: 95,
          thirdSeriesYValue: 71),
    ];
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(

          /// To apply the column width here.
          width: isCardView ? 0.8 : _columnWidth,

          /// To apply the spacing betweeen to two columns here.
          spacing: isCardView ? 0.2 : _columnSpacing,
          dataSource: chartData,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Viếng thăm'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Có đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.green,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Số đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.red,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Doanh số'),
    ];
  }

  ///Get the column series
  List<ColumnSeries<ChartSampleData, String>> _getLevel2Column() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'TUYẾN Q1',
          y: 128,
          secondSeriesYValue: 129,
          thirdSeriesYValue: 101),
      ChartSampleData(
          x: 'TUYẾN Q2', y: 123, secondSeriesYValue: 92, thirdSeriesYValue: 93),
      ChartSampleData(
          x: 'TUYẾN Q3',
          y: 107,
          secondSeriesYValue: 106,
          thirdSeriesYValue: 90),
      ChartSampleData(
          x: 'TUYẾN Q4', y: 87, secondSeriesYValue: 95, thirdSeriesYValue: 71),
      ChartSampleData(
          x: 'TUYẾN Q5', y: 87, secondSeriesYValue: 95, thirdSeriesYValue: 71),
    ];
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(

          /// To apply the column width here.
          width: isCardView ? 0.8 : _columnWidth,

          /// To apply the spacing betweeen to two columns here.
          spacing: isCardView ? 0.2 : _columnSpacing,
          dataSource: chartData,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Viếng thăm'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Có đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.green,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Số đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.red,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Doanh số'),
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getLevel3Column() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'TUYẾN Q1',
          y: 128,
          secondSeriesYValue: 129,
          thirdSeriesYValue: 101),
      ChartSampleData(
          x: 'TUYẾN Q2', y: 123, secondSeriesYValue: 92, thirdSeriesYValue: 93),
      ChartSampleData(
          x: 'TUYẾN Q3',
          y: 107,
          secondSeriesYValue: 106,
          thirdSeriesYValue: 90),
      ChartSampleData(
          x: 'TUYẾN Q4', y: 87, secondSeriesYValue: 95, thirdSeriesYValue: 71),
      ChartSampleData(
          x: 'TUYẾN Q5', y: 87, secondSeriesYValue: 95, thirdSeriesYValue: 71),
    ];
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(

          /// To apply the column width here.
          width: isCardView ? 0.8 : _columnWidth,

          /// To apply the spacing betweeen to two columns here.
          spacing: isCardView ? 0.2 : _columnSpacing,
          dataSource: chartData,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Viếng thăm'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Có đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.green,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Số đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: isCardView ? 0.8 : _columnWidth,
          spacing: isCardView ? 0.2 : _columnSpacing,
          color: Colors.red,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Doanh số'),
    ];
  }
}
