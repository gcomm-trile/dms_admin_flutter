import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/style.dart';

import 'local_widgets/chart_sample_data.dart';
import 'local_widgets/column_default.dart';
import 'local_widgets/stacked_column_chart.dart';

class ContentDesktop extends StatefulWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;
  ContentDesktop({Key key, @required this.onNavigationChanged})
      : super(key: key);
  @override
  _ContentDesktopState createState() => _ContentDesktopState();
}

class _ContentDesktopState extends State<ContentDesktop> {
  int selectedButtonIndex = 1;
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

  card(
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
              child: Center(
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

  @override
  Widget build(BuildContext context) {
    List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
        x: '27/02',
        y: 3,
        yValue: 2,
        secondSeriesYValue: 20,
      ),
      ChartSampleData(
        x: '28/02',
        y: 1,
        yValue: 0,
        secondSeriesYValue: 20,
      ),
      ChartSampleData(
        x: '01/03',
        y: 0,
        yValue: 0,
        secondSeriesYValue: 20,
      ),
      ChartSampleData(
        x: '02/03',
        y: 0,
        yValue: 2,
        secondSeriesYValue: 15,
      ),
    ];
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Text('Dashboard '),
              Expanded(child: Container()),
              ElevatedButton(
                style: getButtonStyle(1),
                child: Text('Hôm nay'),
                onPressed: () {
                  setState(() {
                    selectedButtonIndex = 1;
                  });
                },
              ),
              SizedBox(width: 5),
              ElevatedButton(
                style: getButtonStyle(2),
                child: Text('Tuần này'),
                onPressed: () {
                  setState(() {
                    selectedButtonIndex = 2;
                  });
                },
              ),
              SizedBox(width: 5),
              ElevatedButton(
                style: getButtonStyle(3),
                child: Text('Tháng này'),
                onPressed: () {
                  setState(() {
                    selectedButtonIndex = 3;
                  });
                },
              ),
              SizedBox(width: 5),
              ElevatedButton(
                style: getButtonStyle(4),
                child: Text('Tháng trước'),
                onPressed: () {
                  setState(() {
                    selectedButtonIndex = 4;
                  });
                },
              ),
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
                    child: card(
                      title: 'Viếng thăm',
                      value: '10/20',
                      tooltip: 'Đạt 50%',
                      color: Colors.yellow,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 2,
                  child: Container(
                    child: card(
                      title: 'Đơn hàng',
                      value: '5',
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 4,
                  child: Container(
                    child: card(
                      title: 'Tổng tiền',
                      value: '20,000,000',
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
              child: cont(
                StackedColumnChart(
                    title: 'Báo cáo doanh số',
                    colorColumn: Colors.red,
                    chartData: chartData,
                    columns: ['HỒ CHÍ MINH', 'BÌNH DƯƠNG', 'HÀ NỘI']),
                StackedColumnChart(
                    title: 'Tỉ lệ hoàn thành',
                    colorColumn: Colors.red,
                    chartData: chartData,
                    columns: ['HỒ CHÍ MINH', 'BÌNH DƯƠNG', 'HÀ NỘI']),
              )),
          SizedBox(height: 10),
          Flexible(
              flex: 2,
              child: Row(
                children: [
                  Flexible(child: ColumnSpacing()),
                  Flexible(
                    child: Container(
                      color: Colors.pink,
                      child: Column(
                        children: [
                          Text('Dữ liệu mới cập nhật'),
                          Expanded(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Text((1000 + index).toString()),
                                    Expanded(child: Text('Nguyễn Văn An')),
                                    Text('22/01 22:40')
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  getButtonStyle(int i) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return Colors.green;
          return i == selectedButtonIndex
              ? Colors.red
              : null; // Use the component's default.
        },
      ),
    );
  }
}
