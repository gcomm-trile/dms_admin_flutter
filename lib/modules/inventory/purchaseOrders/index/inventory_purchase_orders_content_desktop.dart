import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'inventory_purchase_orders_controller.dart';

class InventoryPurchaseOrdersContentDesktop extends StatelessWidget {
  final InventoryPurchaseOrdersController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;
  InventoryPurchaseOrdersContentDesktop({Key key, this.onNavigationChanged})
      : super(key: key);

  final sizedBox = SizedBox(
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Mua hàng',
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
                  onNavigationChanged(NavigationCallBackModel(
                      module: DrawModule.INVENTORY_PURCHASE_ORDERS,
                      function: DrawFunction.NEW,
                      id: Guid.newGuid.toString()));
                  // controller.create();
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
                        'Tạo phiếu mua hàng',
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
            module: 'inventory_purchase_orders',
            filterDataChange: (data) =>
                controller.updateDataByFilterChange(data),
          ),
          SizedBox(
            height: 15,
          ),
          GetX<InventoryPurchaseOrdersController>(
              init: controller,
              initState: (state) => controller.refreshData(null),
              builder: (_) {
                return controller.isBusy.value == true
                    ? Expanded(
                        child: Center(child: CircularProgressIndicator()))
                    : (controller.result.value.length == 0
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
                                    itemCount: controller.result.value.length,
                                    itemBuilder: (context, index) {
                                      return _buildRowListViewSection(
                                          controller.result.value[index]);
                                    },
                                  ),
                                ),
                              ],
                            )),
                          ));
              }),
        ],
      ),
    );
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
              child: Text(
                'Nhà phân phối',
                style: kStyleListViewHeader,
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 60,
            child: Text(
              'Kho',
              style: kStyleListViewHeader,
            ),
          ),
          sizedBox,
          Container(
            width: 80,
            child: Row(
              children: [
                Text(
                  'Tình trạng',
                  style: kStyleListViewHeader,
                ),
              ],
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              'Số lượng',
              style: kStyleListViewHeader,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowListViewSection(PurchaseOrder data) {
    var color = data.status == 2
        ? Colors.blue
        : (data.status == 0 ? Colors.red : Colors.green);
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
                    data.no,
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
              DateTimeHelper.day2Text(data.planDate),
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          sizedBox,
          Expanded(
            child: Container(
              child: Text(TextHelper.toSafeString(data.vendorName)),
            ),
          ),
          sizedBox,
          Container(
            width: 60,
            child: Text(
              data.inStockName,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 80,
            child: Text(
              data.statusName,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Center(
              child: LinearPercentIndicator(
                width: 100,
                animation: true,
                lineHeight: 16.0,
                animationDuration: 2000,
                percent: data.totalInQty * 1.0 / data.totalOrderQty * 1.0,
                animateFromLastPercent: true,
                center: Text(
                  '${data.totalInQty.toString()}/${data.totalOrderQty.toString()}',
                  style: TextStyle(color: Colors.white, fontSize: 11),
                ),
                linearStrokeCap: LinearStrokeCap.roundAll,
                progressColor: color,
                // maskFilter: MaskFilter.blur(
                //     BlurStyle.solid, 3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
