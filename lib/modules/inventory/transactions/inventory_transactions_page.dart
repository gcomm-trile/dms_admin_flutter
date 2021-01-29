import 'package:dms_admin/data/repository/inventory_transactions_repository.dart';
import 'package:dms_admin/global_widgets/drawer.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/modules/inventory/transactions/inventory_transactions_controller.dart';
import 'package:dms_admin/utils/constants.dart';
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

  get buildPage {
    return GetX<InventoryTransactionsController>(
      init: controller,
      initState: (state) => controller.getAll(),
      builder: (_) {
        if (controller.isBusy.value == true)
          return Center(child: CircularProgressIndicator());
        else
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
                          onValueChanged: (filterExpressions) => controller
                              .updateDataByFilterChange(filterExpressions),
                        ),
                        // Row(
                        //   children: [
                        //     RaisedButton(
                        //         color: Colors.white,
                        //         child: Row(
                        //           children: [
                        //             Icon(Icons.filter_alt),
                        //             Text('Thêm điều kiện lọc'),
                        //           ],
                        //         ),
                        //         onPressed: () {
                        //           controller.showFilterDialog();
                        //         }),
                        //     SizedBox(
                        //       width: 10,
                        //     ),
                        //     controller.filterExpressions.length > 0
                        //         ? RaisedButton(
                        //             child: Row(
                        //               children: [
                        //                 Icon(Icons.save_rounded),
                        //                 Text('Lưu bộ lọc'),
                        //               ],
                        //             ),
                        //             onPressed: () {
                        //               // controller.saveFilter(context);
                        //             },
                        //           )
                        //         : SizedBox(
                        //             width: 1,
                        //           ),
                        //   ],
                        // ),
                        // Container(
                        //   height: 20,
                        //   child: ListView.separated(
                        //     separatorBuilder: (context, index) => Divider(
                        //       thickness: 0.5,
                        //     ),
                        //     //shrinkWrap: true,
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: controller.filterExpressions.length,
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //         // margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        //         padding: EdgeInsets.only(left: 10, right: 10),
                        //         decoration: BoxDecoration(
                        //           color: Colors.grey[350],
                        //           borderRadius: BorderRadius.circular(5),
                        //         ),
                        //         child: Row(children: [
                        //           Text(
                        //             controller.filterExpressions[index]
                        //                 .getDisplayName(),
                        //             style: TextStyle(
                        //               fontSize: 11,
                        //             ),
                        //           ),
                        //           InkWell(
                        //             onTap: () {
                        //               controller.filterExpressionRemove(index);
                        //             },
                        //             child: Icon(
                        //               Icons.close,
                        //               size: 17,
                        //             ),
                        //           ),
                        //         ]),
                        //       );
                        //     },
                        //   ),
                        // ),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      kNumberFormat.format(
                                          controller.result[index].inQty),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: color,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      kNumberFormat.format(
                                          controller.result[index].inQty),
                                      style: TextStyle(
                                          color: color,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      kNumberFormat.format(
                                          controller.result[index].inQty),
                                      style: TextStyle(
                                          color: color,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    width: 70,
                                    child: Text(
                                      kNumberFormat.format(controller
                                          .result[index].totalPriceAvg),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize =
        MediaQuery.of(context).size; // need for active change width of screen ;
    print('size ' + screenSize.toString());
    return Scaffold(
      body: Row(
        children: [
          AppDrawer(selectedModule: 'Tồn kho'),
          Expanded(child: buildPage)
        ],
      ),
    );
  }
}
