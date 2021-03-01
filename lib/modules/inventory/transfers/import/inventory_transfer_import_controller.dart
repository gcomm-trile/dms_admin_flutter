import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/transfer.dart';
import 'package:dms_admin/data/repository/inventory_transfers_repository.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryTransferImportController extends GetxController {
  final InventoryTransfersRepository repository;

  InventoryTransferImportController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;

  var result = Rx<Transfer>();
  var products = <Product>[].obs;

  void getId(String id) {
    isBusy(true);
    repository.getId(id).then((data) {
      result.value = data;

      result.value.id = id;
      if (result.value.products != null) {
        products(result.value.products);
      }

      isBusy(false);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  save() async {
    var data = await repository.nhanOrHuy(
        result.value.id, result.value.status == 2 ? 'nhan' : 'huy');
    if (data.toString().isEmpty) {
      UI.showSuccess('Đã tạo thành công');
      return true;
    } else {
      UI.showError(data.toString());
      return false;
    }
  }

  sumQtyOut() {
    if (products == null) return 0;
    return (products == null || products.length == 0)
        ? 0
        : products.fold(
            0, (previousValue, element) => previousValue + element.outQty);
  }
}
