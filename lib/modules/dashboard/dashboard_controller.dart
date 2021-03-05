import 'dart:math';
import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/report_model.dart';
import 'package:dms_admin/data/repository/dashboard_repository.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'local_widgets/chart_sample_data.dart';

class DashboardController extends GetxController {
  final DashboardRepository repository;
  Random random = new Random();
  var levelColumn = <ColumnSeries<ChartSampleData, String>>[].obs;
  var chartData = <ChartSampleData>[].obs;
  DashboardController({@required this.repository}) : assert(repository != null);
  final textToday = 'Hôm nay'.obs;
  final selectedButtonIndex = 1.obs;
  final isBusy = false.obs;
  var totalVisit = ''.obs;
  var totalOrderCount = ''.obs;
  var totalRevenue = ''.obs;

  var level = 1.obs;
  var province = ''.obs;
  var tuyen = ''.obs;
  var routeId = '00000000-0000-0000-0000-000000000000';
  var nhanvien = ''.obs;
  var userId = '00000000-0000-0000-0000-000000000000';
  ReportModel result;

  getData() {
    isBusy.value = true;
    repository
        .getAll(selectedButtonIndex.value, level.value, province.value, routeId,
            userId)
        .then((value) {
      result = value;
      totalVisit.value = result == null
          ? '0'
          : kNumberFormat.format(result.dataChart.fold(0,
              (previousValue, element) => previousValue + element.countOrder));
      totalOrderCount.value = result == null
          ? '0'
          : kNumberFormat.format(result.dataChart.fold(0,
              (previousValue, element) => previousValue + element.countVisit));
      totalRevenue.value = result == null
          ? '0'
          : kNumberFormat.format(result.dataChart.fold(
              0,
              (previousValue, element) =>
                  previousValue + element.sumOrderPrice));

      var x = <ChartSampleData>[];
      for (var item in result.dataChart) {
        x.add(ChartSampleData(
            x: item.name,
            y: item.countVisit,
            yValue: item.countOrder,
            secondSeriesYValue: item.countStoreOrder,
            thirdSeriesYValue: item.sumOrderPrice / 1000000));
      }
      chartData(x);
      levelColumn(_getLevel1Column());
      print(levelColumn.length.toString());
      isBusy.value = false;
    }).catchError((handleError) {
      isBusy.value = false;
      UI.showError(handleError.toString());
    });
  }

  void setSelectedButtonIndex(int i) {
    if (i != selectedButtonIndex.value) {
      selectedButtonIndex.value = i;
      getData();
    }
  }

  levelDown() {
    if (level.value > 1) {
      level.value--;
      print('set level ' + level.value.toString());
      getData();
    }
  }

  void levelUp() {
    if (level.value < 4) {
      level.value++;
      print('set level ' + level.value.toString());
      getData();
    }
  }

  List<ColumnSeries<ChartSampleData, String>> _getLevel1Column() {
    double _columnWidth = 0.8;
    double _columnSpacing = 0.2;

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
          yValueMapper: (ChartSampleData sales, _) => sales.thirdSeriesYValue,
          name: 'Doanh số'),
    ];
  }

  findMaximumChart() {
    if (result == null || result.dataChart.length == 0)
      return 0;
    else {
      int max = 0;
      for (var item in result.dataChart) {
        if (item.countOrder > max) max = item.countOrder;
        if (item.countVisit > max) max = item.countVisit;
        if (item.countStoreOrder > max) max = item.countStoreOrder;
        if (item.sumOrderPrice ~/ 1000000 > max)
          max = item.sumOrderPrice ~/ 1000000;
      }
      print('max ' + ((max ~/ 10 + 1) * 10).toString());
      return ((max ~/ 10 + 1) * 10).toDouble();
    }
  }

  void setChange(String text) {
    switch (level.value) {
      case 1:
        {
          province.value = text;
        }
        break;
      case 2:
        {
          routeId = result.dataChart
              .where((element) => element.name == text)
              .first
              .id;
          tuyen.value = text;
        }
        break;
      case 3:
        {
          userId = result.dataChart
              .where((element) => element.name == text)
              .first
              .id;
          nhanvien.value = text;
        }
        break;

      default:
    }
    // controller.khuvuc.value = axisLabelTapArgs.text;
    // controller.tuyen.value = '';
    // controller.nhanvien.value = '';
    // controller.level.value = 2;
  }
}
