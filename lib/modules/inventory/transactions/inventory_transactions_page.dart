import 'package:dms_admin/data/repository/inventory_transactions_repository.dart';
import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_controller.dart';

import 'package:dms_admin/widgets/sliver_grid_delegate_with_fixed_cross_axis_count_and_fixed_height.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'local_widgets/card.dart';

class InventoryTransactionsPage extends StatelessWidget {
  final InventoryTransactionsController controller =
      InventoryTransactionsController(
          repository: InventoryTransactionsRepository(
    apiClient: Get.find(),
  ));
  InventoryTransactionsPage({Key key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    var screenSize =
        MediaQuery.of(context).size; // need for active change width of screen ;
    print(Get.width);
    return Scaffold(
        body: Row(
      children: [
        AppDrawer(),
        Expanded(
          child: GetX<InventoryTransactionsController>(
            init: controller,
            initState: (state) => controller.getAll(),
            builder: (_) {
              if (controller.isBusy.value == true)
                return Center(child: CircularProgressIndicator());
              else
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
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
                            RaisedButton(
                              color: Colors.blue,
                              child: Text(
                                'Xuất file',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                print(Get.width);
                              },
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
                        DataTable(columns: <DataColumn>[
                          DataColumn(
                            tooltip: 'Kho chứa sản phẩm',
                            label: Container(
                              width: 70,
                              child: Text(
                                'Kho',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Container(
                                child: Text(
                                  'Sản phẩm ',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 25,
                              child: Text(
                                'Tồn',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 65,
                              child: Text(
                                'Khả dụng',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              width: 25,
                              child: Text(
                                'Đặt',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              // width: 40,
                              child: Text(
                                'Giá(vnđ)',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ], rows: controller.createDataSource()),
                      ],
                    ),
                  ),
                );
            },
          ),
        ),
      ],
    ));
  }
}
