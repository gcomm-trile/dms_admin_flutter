import 'package:dms_admin/modules/dashboard/dashboard_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_sample_data.dart';

class ColumnSpacing extends StatefulWidget {
  /// Creates the column chart with columns width and space change option
  const ColumnSpacing({Key key}) : super(key: key);

  @override
  _ColumnSpacingState createState() => _ColumnSpacingState();
}

class _ColumnSpacingState extends State {
  int level = 1;
  dynamic chart;
  TooltipBehavior _tooltipBehavior;
  double _columnWidth = 0.8;
  double _columnSpacing = 0.2;
  String khuvuc = '';
  String tuyen = '';
  String nhanvien = '';

  _ColumnSpacingState();

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: false);
    chart = getLevel1Chart();
    super.initState();
  }

  getChart() {
    switch (level) {
      case 1:
        return getLevel1Chart();
      case 2:
        return getLevel2Chart();
      case 3:
        return getLevel3Char();
      case 4:
        return getLevel4Char();
      default:
        return Container(
          color: Colors.red,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build chart master level ' + level.toString());
    return Stack(
      children: <Widget>[
        getChart(),
        Positioned(
          left: 3,
          top: 3,
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
      onAxisLabelTapped: (axisLabelTapArgs) {
        print('click onAxisLabelTapped ' + axisLabelTapArgs.text);
        setState(() {
          khuvuc = axisLabelTapArgs.text;
          tuyen = '';
          nhanvien = '';
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

  getLevel2Chart() {
    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Khu vực ' + khuvuc),
      onAxisLabelTapped: (axisLabelTapArgs) {
        print('click onAxisLabelTapped ' + axisLabelTapArgs.text);
        setState(() {
          khuvuc = khuvuc;
          tuyen = axisLabelTapArgs.text;
          nhanvien = '';
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

  getLevel3Char() {
    return chart = SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      onAxisLabelTapped: (axisLabelTapArgs) {
        print('click onAxisLabelTapped ' + axisLabelTapArgs.text);
        setState(() {
          khuvuc = khuvuc;
          tuyen = tuyen;
          nhanvien = axisLabelTapArgs.text;
          level = 4;
        });
      },
      title: ChartTitle(text: 'Tuyến ' + tuyen),
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

  getLevel4Char() {
    return chart = SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Nhân viên ' + nhanvien),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          maximum: 150,
          minimum: 0,
          interval: 25,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: _getLevel4Column(),
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
          width: _columnWidth,
          spacing: _columnSpacing,
          dataSource: chartData,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Viếng thăm'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Có đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.green,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Số đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
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
          width: _columnWidth,
          spacing: _columnSpacing,
          dataSource: chartData,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Viếng thăm'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Có đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.green,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Số đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.red,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Doanh số'),
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getLevel3Column() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'NGUYỄN VĂN AN',
          y: 128,
          secondSeriesYValue: 129,
          thirdSeriesYValue: 101),
      ChartSampleData(
          x: 'ĐỖ XUÂN HIỆP',
          y: 123,
          secondSeriesYValue: 92,
          thirdSeriesYValue: 93),
      ChartSampleData(
          x: 'TRẦN QUANG THẮNG',
          y: 107,
          secondSeriesYValue: 106,
          thirdSeriesYValue: 90),
      ChartSampleData(
          x: 'LÊ MINH TRÍ',
          y: 87,
          secondSeriesYValue: 95,
          thirdSeriesYValue: 71),
      ChartSampleData(
          x: 'NGUYỄN TRƯƠNG KIM CHÂU',
          y: 87,
          secondSeriesYValue: 95,
          thirdSeriesYValue: 71),
    ];
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(

          /// To apply the column width here.
          width: _columnWidth,
          spacing: _columnSpacing,
          dataSource: chartData,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Viếng thăm'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Có đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.green,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Số đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.red,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Doanh số'),
    ];
  }

  List<ColumnSeries<ChartSampleData, String>> _getLevel4Column() {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: '01/03', y: 128, secondSeriesYValue: 129, thirdSeriesYValue: 101),
      ChartSampleData(
          x: '02/03', y: 123, secondSeriesYValue: 92, thirdSeriesYValue: 93),
      ChartSampleData(
          x: '03/03', y: 107, secondSeriesYValue: 106, thirdSeriesYValue: 90),
      ChartSampleData(
          x: '04/03', y: 87, secondSeriesYValue: 95, thirdSeriesYValue: 71),
      ChartSampleData(
          x: '05/03', y: 87, secondSeriesYValue: 95, thirdSeriesYValue: 71),
    ];
    return <ColumnSeries<ChartSampleData, String>>[
      ColumnSeries<ChartSampleData, String>(
          width: _columnWidth,
          spacing: _columnSpacing,
          dataSource: chartData,
          color: const Color.fromRGBO(252, 216, 20, 1),
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.y,
          name: 'Viếng thăm'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.blue,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Có đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.green,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Số đơn'),
      ColumnSeries<ChartSampleData, String>(
          dataSource: chartData,
          width: _columnWidth,
          spacing: _columnSpacing,
          color: Colors.red,
          xValueMapper: (ChartSampleData sales, _) => sales.x,
          yValueMapper: (ChartSampleData sales, _) => sales.secondSeriesYValue,
          name: 'Doanh số'),
    ];
  }
}
