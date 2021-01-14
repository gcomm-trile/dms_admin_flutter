import 'package:dms_admin/data/model/inventory_purchase_order.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/repository/inventory_purchase_order_repository.dart';

import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'inventory_purchase_order_new.dart';

class InventoryPurchaseOrderController extends GetxController {
  final InventoryPurchaseOrderRepository repository;
  InventoryPurchaseOrderController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  Rx<List<PurchaseOrder>> result = Rx<List<PurchaseOrder>>();

  void getAll() {
    print('run');
    // log('busy' + isBusy.value.toString());
    isBusy(true);
    // log('busy' + isBusy.value.toString());
    repository.getAll().then((data) {
      result.value = data;
      isBusy(false);
      // log('busy' + irsBusy.value.toString());
      print('return data  ');
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  void createPurchaseOrder() {
    Get.to(InventoryPurchaseOrderNewPage(
      purchaseOrderId: Guid.newGuid.toString(),
    ));
  }
}
