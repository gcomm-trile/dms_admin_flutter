import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/global_widgets/header_appbar/header_appbar_mobile.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'order_controller.dart';

class OrderContentMobile extends StatelessWidget {
  final OrderController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;
  OrderContentMobile({Key key, this.onNavigationChanged}) : super(key: key);

  final sizedBox = SizedBox(
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          HeaderAppBarMobile(
            title: 'Đặt hàng',
          ),
          SizedBox(
            height: 15,
          ),
          FilterWidget(
            module: 'orders',
            filterDataChange: (data) =>
                controller.updateDataByFilterChange(data),
          ),
          SizedBox(
            height: 15,
          ),
          GetX<OrderController>(
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
                                      return _buildRowListViewSection(index);
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
            width: 100,
            child: Text(
              'Mã',
              style: kStyleListViewHeader,
            ),
          ),
          sizedBox,
          Expanded(
            child: Container(
              child: Text(
                'Tên C/H',
                style: kStyleListViewHeader,
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              'Kho xuất',
              style: kStyleListViewHeader,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowListViewSection(int index) {
    var data = controller.result.value[index];
    var color = Colors.blue;
    return Container(
      child: Row(
        children: [
          InkWell(
            onTap: () {
              onNavigationChanged(NavigationCallBackModel(
                  module: DrawModule.ORDERS,
                  function: DrawFunction.IMPORT,
                  id: data.id));
            },
            child: Row(
              children: [
                Container(
                  width: 70,
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
                  size: 30,
                  color: Color.fromARGB(255, 15, 7, 240),
                ),
              ],
            ),
          ),
          sizedBox,
          Expanded(
            child: Container(
              child: Text(
                data.storeName,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              data.isExportStock == true ? data.exportStockName : '---',
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
