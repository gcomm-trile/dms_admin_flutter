import 'package:dms_admin/data/model/adjustment_model.dart';

import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'inventory_adjustments_controller.dart';

class InventoryAdjustmentsPage extends StatelessWidget {
  final InventoryAdjustmentsController controller =
      InventoryAdjustmentsController(repository: Get.find());
  InventoryAdjustmentsPage({Key key}) : super(key: key);

  final sizedBox = SizedBox(
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        AppDrawer(selectedModule: 'Điều chỉnh'),
        Expanded(
          child: GetX<InventoryAdjustmentsController>(
            init: controller,
            initState: (state) => controller.getAll(),
            builder: (_) {
              if (controller.isBusy.value == true)
                return Center(child: CircularProgressIndicator());
              else {
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Danh sách phiếu điều chỉnh',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          RaisedButton(
                            color: Colors.blue,
                            onPressed: () {
                              controller.create();
                            },
                            child: Container(
                              height: 37,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Tạo phiếu điều chỉnh',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      FilterWidget(
                        // filterExpressions: controller.filterExpressions,
                        module: 'inventory_adjustments',
                       
                        products: [],
                        stocks: [],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      controller.adjustments.value.length == 0
                          ? Expanded(
                              child: Center(
                                child: Text('Không có dữ liệu'),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                  child: Column(
                                children: [
                                  _buildHeaderListViewSection(),
                                  Divider(
                                    thickness: 2.0,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                        thickness: 2.0,
                                      ),
                                      itemCount:
                                          controller.adjustments.value.length,
                                      itemBuilder: (context, index) {
                                        return _buildRowListViewSection(
                                            controller
                                                .adjustments.value[index]);
                                      },
                                    ),
                                  ),
                                ],
                              )),
                            ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    ));
  }

  _buildHeaderListViewSection() {
    return Container(
      child: Row(
        children: [
          Container(
            width: 85,
            child: Text(
              'Mã',
              style: kStyleListViewHeader,
            ),
          ),
          sizedBox,
          Container(
            width: 90,
            child: Text(
              'Ngày dự kiến',
              style: kStyleListViewHeader,
            ),
          ),
          sizedBox,
          Expanded(
            child: Container(
              width: 60,
              child: Text(
                'Kho',
                style: kStyleListViewHeader,
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              'Lí do',
              style: kStyleListViewHeader,
            ),
          ),
          sizedBox,
          Container(
            width: 60,
            child: Text(
              'Số lượng',
              style: kStyleListViewHeader,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowListViewSection(AdjustmentModel data) {
    return Container(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              controller.goToDetail(data);
            },
            child: Row(
              children: [
                Container(
                  width: 60,
                  child: Text(
                    '#' + TextHelper.toSafeString(data.no),
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 7, 240),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Icon(
                  Icons.list,
                  size: 25,
                  color: Color.fromARGB(255, 15, 7, 240),
                ),
              ],
            ),
          ),
          sizedBox,
          Container(
            width: 90,
            child: Text(
              DateTimeHelper.day2Text(data.createdOn),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          sizedBox,
          Expanded(
            child: Container(
              child: Text(
                data.inStockName,
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              TextHelper.toSafeString(
                data.reasonName,
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 60,
            child: Text(
              TextHelper.toSafeString(
                kNumberFormat.format(data.totalQty),
              ),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
