import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/modules/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:split_view/split_view.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'local_widgets/chart_sample_data.dart';
import 'local_widgets/stacked_column_chart.dart';

class ContentDesktop extends StatefulWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;
  ContentDesktop({Key key, @required this.onNavigationChanged})
      : super(key: key);
  @override
  _ContentDesktopState createState() => _ContentDesktopState();
}

class _ContentDesktopState extends State<ContentDesktop> {
  dynamic chart;
  TooltipBehavior _tooltipBehavior;
  double _columnWidth = 0.8;
  double _columnSpacing = 0.2;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: false);
    chart = getLevel1Chart();
    super.initState();
  }

  final DashboardController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetX<DashboardController>(
      init: controller,
      initState: controller.getData(),
      builder: (_) {
        print('rebuild dashboard');
        return Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Dashboard '),
                  Expanded(child: Container()),
                  _button(controller.textToday.value, 1),
                  SizedBox(width: 5),
                  _button('Tuần này', 2),
                  SizedBox(width: 5),
                  _button('Tháng này', 3),
                  SizedBox(width: 5),
                  _button('Tháng trước', 4),
                  SizedBox(width: 5),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 100,
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: _card(
                          title: 'Viếng thăm',
                          value: controller.totalVisit.value,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 2,
                      child: Container(
                        child: _card(
                          title: 'Đơn hàng',
                          value: controller.totalOrderCount.value,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      flex: 4,
                      child: Container(
                        child: _card(
                          title: 'Tổng tiền',
                          value: controller.totalRevenue.value,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 2,
                child: controller.isBusy.value == true
                    ? Center(child: CircularProgressIndicator())
                    : Stack(
                        children: <Widget>[
                          getChart(),
                          Positioned(
                            left: 3,
                            top: 3,
                            child: Visibility(
                              visible: controller.level.value > 1,
                              child: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () => controller.levelDown()),
                            ),
                          ),
                        ],
                      ),
              ),
              SizedBox(height: 10),
              Flexible(
                flex: 2,
                child: SplitView(
                  gripSize: 3,
                  viewMode: SplitViewMode.Horizontal,
                  initialWeight: 0.7,
                  view1: Container(
                      child: StackedColumnChart(
                          title: 'Báo cáo doanh số',
                          colorColumn: Colors.red,
                          chartData: controller.chartData,
                          columns: ['HỒ CHÍ MINH', 'BÌNH DƯƠNG', 'HÀ NỘI'])),
                  view2: controller.isBusy.value == true
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: controller.result.dataActivity.length == 0
                                ? Center(child: Text('Không có dữ liệu'))
                                : Column(
                                    children: [
                                      Text(
                                        'Dữ liệu mới cập nhật',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              Divider(
                                            thickness: 0.5,
                                            color: Colors.black,
                                          ),
                                          itemCount: controller
                                              .result.dataActivity.length,
                                          itemBuilder: (context, index) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                    child: Text(controller
                                                        .result
                                                        .dataActivity[index]
                                                        .content)),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getButtonStyle(int i) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return Colors.green;
          return i == controller.selectedButtonIndex.value
              ? Colors.red
              : null; // Use the component's default.
        },
      ),
    );
  }

  Widget cont(Widget item1, Widget item2) {
    return Row(
      children: [
        Flexible(
          child: item1,
        ),
        SizedBox(width: 10),
        Flexible(
          child: item2,
        ),
      ],
    );
  }

  _button(String text, int index) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: controller.selectedButtonIndex.value == index
            ? Colors.red
            : Colors.purple,
      ),
      child: Text(text),
      onPressed: () => controller.setSelectedButtonIndex(index),
    );
  }

  _card(
      {@required title,
      @required String value,
      String tooltip = '',
      @required Color color}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text(
                title,
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: controller.isBusy.value == true
                  ? Center(child: CircularProgressIndicator())
                  : Center(
                      child: tooltip.isEmpty
                          ? Text(
                              value,
                              style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontSize.xxLarge.size,
                                  letterSpacing: 3),
                            )
                          : Tooltip(
                              message: tooltip,
                              child: Text(
                                value,
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: FontSize.xxLarge.size,
                                    letterSpacing: 3),
                              ),
                            ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  getTitle() {
    switch (controller.level.value) {
      case 1:
        return 'Khu vực';
        break;
      case 2:
        return 'Tuyến';
        break;
      case 3:
        return 'Nhân viên';
        break;
      case 4:
        return 'Hoạt động';
        break;
      default:
        return '';
    }
  }

  getChart() {
    return SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: getTitle()),
      onAxisLabelTapped: (axisLabelTapArgs) {
        print('click onAxisLabelTapped ' + axisLabelTapArgs.text);
        controller.setChange(axisLabelTapArgs.text);
        controller.levelUp();
      },
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          maximum: controller.findMaximumChart(),
          minimum: 0,
          interval: 2,
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(size: 0)),
      series: controller.levelColumn,
      legend: Legend(isVisible: true),
    );
  }

  SfCartesianChart getLevel1Chart() {
    return chart = SfCartesianChart(
      tooltipBehavior: _tooltipBehavior,
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Báo cáo khu vực'),
      onAxisLabelTapped: (axisLabelTapArgs) {
        print('click onAxisLabelTapped ' + axisLabelTapArgs.text);
        controller.province.value = axisLabelTapArgs.text;
        controller.tuyen.value = '';
        controller.nhanvien.value = '';
        controller.level.value = 2;
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
