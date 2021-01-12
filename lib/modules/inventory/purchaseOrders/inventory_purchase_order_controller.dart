import 'package:dms_admin/data/model/inventory_purchase_order.dart';
import 'package:dms_admin/data/repository/inventory_purchase_order.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import 'inventory_purchase_order_new.dart';

class InventoryPurchaseOrderController extends GetxController {
  final InventoryPurchaseOrderRepository repository;
  InventoryPurchaseOrderController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  Rx<List<InventoryPurchaseOrder>> result = Rx<List<InventoryPurchaseOrder>>();

  void getAll() {
    print('run');
    // log('busy' + isBusy.value.toString());
    isBusy(true);
    // log('busy' + isBusy.value.toString());
    repository.getAll().then((data) {
      result.value = data;
      isBusy(false);
      // log('busy' + isBusy.value.toString());
      print('return data  ');
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  void create_purchase_order() {
    Get.to(InventoryPurchaseOrderNewPage());
  }
}
