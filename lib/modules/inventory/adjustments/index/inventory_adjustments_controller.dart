import 'package:dms_admin/data/model/adjustment.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/repository/inventory_adjustments_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryAdjustmentsController extends GetxController {
  final InventoryAdjustmentsRepository repository;
  InventoryAdjustmentsController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  var result = Rx<List<Adjustment>>();

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
    // Get.to(InventoryPurchaseOrderNewPage(
    //   purchaseOrderId: Guid.newGuid.toString(),
    // ));
  }

  void goToDetail(Adjustment data) {
    // Get.to(InventoryPurchaseOrderImportPage(
    //   purchaseOrderId: data.id,
    // ));
  }
}
