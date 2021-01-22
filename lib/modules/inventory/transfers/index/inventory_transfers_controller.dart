import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/repository/inventory_transfers_repository.dart';
import 'package:dms_admin/modules/inventory/transfers/new/inventory_transfer_new_page.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter_guid/flutter_guid.dart';
import '../import/inventory_purchase_order_import.dart';

class InventoryTransfersController extends GetxController {
  final InventoryTransfersRepository repository;
  InventoryTransfersController({@required this.repository})
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

  void goToDetail(PurchaseOrder data) {
    Get.to(InventoryPurchaseOrderImportPage(
      purchaseOrderId: data.id,
    ));
  }

  void createTransfer() {
    Get.to(InventoryTransferNewPage(
      id: Guid.newGuid.toString(),
    ));
  }
}
