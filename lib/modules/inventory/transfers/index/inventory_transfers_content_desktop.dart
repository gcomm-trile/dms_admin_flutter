import 'package:dms_admin/Models/navagion_callback_model.dart';
import 'package:dms_admin/data/model/transfer.dart';
import 'package:dms_admin/routes/app_drawer.dart';
import 'package:dms_admin/theme/text_theme.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/datetime_helper.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';
import 'inventory_transfers_controller.dart';

class InventoryTransfersContentDesktop extends StatelessWidget {
  final Function(NavigationCallBackModel data) onNavigationChanged;
  final InventoryTransfersController controller = Get.find();
  InventoryTransfersContentDesktop({Key key, this.onNavigationChanged})
      : super(key: key);

  final sizedBox = SizedBox(
    width: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GetX<InventoryTransfersController>(
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
                            'Điều chuyển',
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
                                  module: DrawModule.INVENTORY_TRANSFERS,
                                  function: DrawFunction.NEW,
                                  id: Guid.newGuid.toString()));
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
                                    'Tạo phiếu điều chuyển',
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
                      SizedBox(
                        height: 15,
                      ),
                      _buildHeaderListViewSection(),
                      Divider(
                        thickness: 2.0,
                      ),
                      Expanded(
                        child: controller.result.value.length == 0
                            ? Center(child: Text('Không có dữ liệu'))
                            : ListView.separated(
                                separatorBuilder: (context, index) => Divider(
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
              'Ngày nhận',
              style: kStyleListViewHeader,
            ),
          ),
          sizedBox,
          Expanded(
            child: Container(
              child: Text(
                'Kho',
                style: kStyleListViewHeader,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 100,
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
            width: 60,
            child: Text(
              'Số lượng',
              style: kStyleListViewHeader,
            ),
          ),
          sizedBox,
          Container(
            width: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildRowListViewSection(Transfer data) {
    var color = data.status == 2
        ? Colors.blue
        : (data.status == 1 ? Colors.red : Colors.green);
    return Container(
      child: Row(
        children: [
          (data.canReceived == true || data.canCancel == true)
              ? InkWell(
                  onTap: () {
                    onNavigationChanged(NavigationCallBackModel(
                        module: DrawModule.INVENTORY_TRANSFERS,
                        function: DrawFunction.IMPORT,
                        id: data.id));
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
                )
              : Container(
                  width: 85,
                  child: Text(
                    data.no,
                    style: TextStyle(
                      color: Color.fromARGB(255, 15, 7, 240),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
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
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(TextHelper.toSafeString(data.outStockName)),
                  Container(
                    child: Icon(Icons.arrow_right_alt),
                  ),
                  Text(TextHelper.toSafeString(data.inStockName)),
                ],
              ),
            ),
          ),
          sizedBox,
          Container(
            width: 100,
            child: Text(
              data.statusName,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          sizedBox,
          Container(
            width: 60,
            child: Text(
              kNumberFormat.format(data.totalQty),
              textAlign: TextAlign.center,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          sizedBox,
          data.canEdit == true
              ? InkWell(
                  child: Container(
                    width: 30,
                    child: Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  onTap: () {
                    print('call detail');
                    if (data.canEdit) {
                      onNavigationChanged(NavigationCallBackModel(
                          module: DrawModule.INVENTORY_TRANSFERS,
                          function: DrawFunction.NEW,
                          id: data.id));
                    }
                  },
                )
              : Container(
                  width: 30,
                ),
        ],
      ),
    );
  }
}
