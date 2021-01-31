import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_controller.dart';
import 'package:dms_admin/utils/color_helper.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:dms_admin/utils/device_screene_type.dart';
import 'package:dms_admin/widgets/sliver_grid_delegate_with_fixed_cross_axis_count_and_fixed_height.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'local_widgets/card.dart';

class InventoryTransactionsPage extends StatelessWidget {
  final InventoryTransactionsController controller = Get.find();
  final DeviceScreenType deviceScreenType;
  //     InventoryTransactionsController(
  //         repository: InventoryTransactionsRepository(
  //   apiClient: Get.find(),
  // ));
  InventoryTransactionsPage({Key key, @required this.deviceScreenType})
      : super(key: key);
  cardRow(int numItemPerRow) {
    var card1 = CardInventoryTransaction(
      title: 'TỔNG LƯỢNG TỒN',
      value: controller.getTongTon(),
      textColor: Colors.black,
    );
    var card2 = CardInventoryTransaction(
      title: 'TỔNG GIÁ BÁN',
      value: controller.getTongGiaBan(),
      textColor: Colors.purple,
    );
    var card3 = CardInventoryTransaction(
      title: 'TỔNG GIÁ TRỊ',
      value: controller.getTongGiaTri(),
      textColor: Colors.blue,
    );
    var card4 = CardInventoryTransaction(
      title: 'TỔNG LỢI NHUẬN',
      value: controller.getTongLoiNhuan(),
      textColor: Colors.green,
    );

    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
          crossAxisCount: numItemPerRow,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          height: 65.0), //48
      children: [
        card1,
        card2,
        card3,
        card4,
      ],
    );
  }

  mobilePage() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[400], ColorHelper.fromHex('#042863')],
          )),
          child: SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                ),
                Text(
                  'Chi tiết tồn kho',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 150, child: cardRow(2)),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Column(
                    children: [
                      FilterWidget(
                        module: 'inventory_transactions',
                        // filterExpressions: controller.filterExpressions,
                        products: [],
                        stocks: [],
                        onValueChanged: (filterExpressions) => controller
                            .updateDataByFilterChange(filterExpressions),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                'Sản phẩm',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Container(
                            width: 70,
                            child: Text(
                              'Tồn',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            width: 70,
                            child: Text(
                              'Đặt',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            width: 70,
                            child: Text(
                              'K.D',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            width: 70,
                            child: Text(
                              'Tổng tiền',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                        color: Colors.black,
                      ),
                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) => Divider(
                          thickness: 1.5,
                        ),
                        itemCount: controller.result.length,
                        itemBuilder: (context, index) {
                          var color = controller.result[index].inQty > 0
                              ? Colors.green
                              : controller.result[index].inQty == 0
                                  ? Colors.yellow
                                  : Colors.red;
                          return Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    controller.result[index].name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Container(
                                width: 70,
                                child: Text(
                                  kNumberFormat
                                      .format(controller.result[index].inQty),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: color,
                                  ),
                                ),
                              ),
                              Container(
                                width: 70,
                                child: Text(
                                  kNumberFormat
                                      .format(controller.result[index].inQty),
                                  style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: 70,
                                child: Text(
                                  kNumberFormat
                                      .format(controller.result[index].inQty),
                                  style: TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                width: 70,
                                child: Text(
                                  kNumberFormat.format(
                                      controller.result[index].totalPriceAvg),
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  desktopPage() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Chi tiết tồn kho',
                textAlign: TextAlign.start,
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: Get.width > 750
                ? 65.0
                : Get.width > 520
                    ? 140
                    : (65.0 * 4 + 30),
            child: Get.width > 750
                ? cardRow(4)
                : Get.width > 520
                    ? cardRow(2)
                    : cardRow(1),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  FilterWidget(
                    module: 'inventory_transactions',
                    // filterExpressions: controller.filterExpressions,
                    products: [],
                    stocks: [],
                    onValueChanged: (filterExpressions) =>
                        controller.updateDataByFilterChange(filterExpressions),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            'Sản phẩm',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          'Tồn',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          'Đặt',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          'K.D',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        width: 70,
                        child: Text(
                          'Tổng tiền',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1.5,
                      ),
                      itemCount: controller.result.length,
                      itemBuilder: (context, index) {
                        var color = controller.result[index].inQty > 0
                            ? Colors.green
                            : controller.result[index].inQty == 0
                                ? Colors.yellow
                                : Colors.red;
                        return Row(
                          children: [
                            Image.network(
                              controller.result[index].imagePath,
                              width: kSizeProductImageWidth,
                              height: kSizeProductImageHeight,
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  controller.result[index].name,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                kNumberFormat
                                    .format(controller.result[index].inQty),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: color,
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                kNumberFormat
                                    .format(controller.result[index].inQty),
                                style: TextStyle(
                                    color: color, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                kNumberFormat
                                    .format(controller.result[index].inQty),
                                style: TextStyle(
                                    color: color, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: 70,
                              child: Text(
                                kNumberFormat.format(
                                    controller.result[index].totalPriceAvg),
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize =
        MediaQuery.of(context).size; // need for active change width of screen ;
    print('rebuld inventory transaction page');
    return GetX<InventoryTransactionsController>(
      init: controller,
      builder: (_) {
        if (controller.isBusy.value == true)
          return Center(child: CircularProgressIndicator());
        else {
          if (deviceScreenType == DeviceScreenType.mobile)
            return mobilePage();
          else
            return desktopPage();
        }
      },
    );
  }
}
