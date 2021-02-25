import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/global_widgets/header_appbar/header_appbar_mobile.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';
import 'inventory_purchase_orders_controller.dart';

class InventoryPurchaseOrdersContentMobile extends StatelessWidget {
  final InventoryPurchaseOrdersController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;
  InventoryPurchaseOrdersContentMobile({Key key, this.onNavigationChanged})
      : super(key: key);

  final sizedBox = SizedBox(
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            HeaderAppBarMobile(title: 'Mua hàng'),
            SizedBox(
              height: 10,
            ),
            FilterWidget(
              // filterExpressions: controller.filterExpressions,
              module: 'inventory_purchase_orders',
              filterDataChange: (data) =>
                  controller.updateDataByFilterChange(data),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: GetX<InventoryPurchaseOrdersController>(
                init: controller,
                initState: (state) => controller.refreshData(null),
                builder: (_) {
                  if (controller.isBusy.value == true)
                    return Center(child: CircularProgressIndicator());
                  else {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _buildHeaderListViewSection(),
                          Divider(
                            thickness: 2.0,
                          ),
                          Expanded(
                            child: controller.result.value.length == 0
                                ? Center(child: Text('Không có dữ liệu'))
                                : ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      thickness: 2.0,
                                    ),
                                    shrinkWrap: true,
                                    itemCount: controller.result.value.length,
                                    itemBuilder: (context, index) {
                                      return _buildRowListViewSection(
                                          controller.result.value[index]);
                                    },
                                  ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            tooltip: 'Tạo mới phiếu mua hàng',
            onPressed: () => onNavigationChanged(onNavigationChanged(
                NavigationCallBackModel(
                    module: DrawModule.INVENTORY_PURCHASE_ORDERS,
                    function: DrawFunction.NEW,
                    id: Guid.newGuid.toString()))),
            child: Icon(Icons.add),
          ),
        )
      ],
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
          Container(
            width: 60,
            child: Text(
              'Kho',
              style: kStyleListViewHeader,
            ),
          ),
          sizedBox,
          Expanded(
            child: Container(
              child: Row(
                children: [
                  Text(
                    'Tình trạng',
                    style: kStyleListViewHeader,
                  ),
                ],
              ),
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
          Container(
            width: 60,
            child: Tooltip(
              message: 'Nhập từ ' + data.vendorName,
              child: Text(
                data.inStockName,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          sizedBox,
          Expanded(
            child: Container(
              width: 80,
              child: Tooltip(
                message:
                    '${data.totalInQty.toString()}/${data.totalOrderQty.toString()}',
                child: Text(
                  data.statusName,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
