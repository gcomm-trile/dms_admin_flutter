import 'package:dms_admin/data/model/transfer.dart';
import 'package:dms_admin/data/repository/inventory_transfers_repository.dart';
import 'package:dms_admin/modules/inventory/transfers/new/inventory_transfer_new_page.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:flutter_guid/flutter_guid.dart';
import '../import/inventory_transfer_import_page.dart';

class InventoryTransfersController extends GetxController {
  final InventoryTransfersRepository repository;
  InventoryTransfersController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  var result = Rx<List<Transfer>>();

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

  void goToDetailPage(Transfer data) {
    Get.to(InventoryTransferNewPage(
      id: data.id,
    ));
  }

  void createTransfer() {
    Get.to(InventoryTransferNewPage(
      id: Guid.newGuid.toString(),
    ));
  }

  void gotoImportPage(Transfer data) {
    Get.to(InventoryTransferImportPage(
      id: data.id,
    ));
  }
}
