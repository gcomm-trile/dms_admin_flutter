import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/data/model/adjustment_model.dart';

import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/global_widgets/header_appbar/header_appbar_mobile.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/color_helper.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';
import 'inventory_adjustments_controller.dart';

class InventoryAdjustmentsContentMobile extends StatelessWidget {
  final InventoryAdjustmentsController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;

  InventoryAdjustmentsContentMobile(
      {Key key, @required this.onNavigationChanged})
      : super(key: key);

  final sizedBox = SizedBox(
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          HeaderAppBarMobile(title: 'Điều chỉnh'),
          SizedBox(
            height: 10,
          ),
          FilterWidget(
            // filterExpressions: controller.filterExpressions,
            module: 'inventory_adjustments',
            filterDataChange: (data) =>
                controller.updateDataByFilterChange(data),
          ),
          SizedBox(
            height: 5,
          ),
          GetX<InventoryAdjustmentsController>(
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
      Positioned(
        right: 10,
        bottom: 10,
        child: FloatingActionButton(
          tooltip: 'Tạo mới phiếu điều chỉnh',
          onPressed: () => onNavigationChanged(onNavigationChanged(
              NavigationCallBackModel(
                  module: DrawModule.INVENTORY_ADJUSTMENTS,
                  function: DrawFunction.NEW,
                  id: Guid.newGuid.toString()))),
          child: Icon(Icons.add),
        ),
      )
    ]);
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
              onNavigationChanged(NavigationCallBackModel(
                  module: DrawModule.INVENTORY_ADJUSTMENTS,
                  function: DrawFunction.NEW,
                  id: data.id));
              // controller.goToDetail(data);
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
