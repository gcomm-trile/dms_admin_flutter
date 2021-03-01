import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/modules/visit/index/visit_controller.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisitContentDesktop extends StatelessWidget {
  final VisitController controller = Get.find();
  final Function(NavigationCallBackModel data) onNavigationChanged;
  VisitContentDesktop({Key key, this.onNavigationChanged}) : super(key: key);

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
                'Viếng thăm',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          FilterWidget(
            // filterExpressions: controller.filterExpressions,
            module: 'visits',
            filterDataChange: (data) =>
                controller.updateDataByFilterChange(data),
          ),
          SizedBox(
            height: 15,
          ),
          GetX<VisitController>(
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
              'Điện thoại',
              style: kStyleListViewHeader,
              textAlign: TextAlign.center,
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              'Nhân viên',
              style: kStyleListViewHeader,
              textAlign: TextAlign.center,
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              'Ngày',
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
              print('1111');
              onNavigationChanged(NavigationCallBackModel(
                  module: DrawModule.VISITS,
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
              child: Tooltip(
                message: TextHelper.toSafeString(data.storeAddress) +
                    ' ,' +
                    TextHelper.toSafeString(data.storeWard) +
                    ' ,' +
                    TextHelper.toSafeString(data.storeDistrict) +
                    ' ,' +
                    TextHelper.toSafeString(data.storeProvince),
                child: Text(
                  TextHelper.toSafeString(data.storeName),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              data.storePhone,
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              data.createdByName,
              style: TextStyle(
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              data.createdOn,
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
