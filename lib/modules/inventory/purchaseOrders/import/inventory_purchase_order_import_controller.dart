import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/model/vendor.dart';
import 'package:dms_admin/data/repository/inventory_purchase_orders_repository.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryPurchaseOrderImportController extends GetxController {
  List<GlobalKey<NumberInputWithIncrementDecrementState>> _key =
      List<GlobalKey<NumberInputWithIncrementDecrementState>>();
  GlobalKey<NumberInputWithIncrementDecrementState> getKey(int index) =>
      _key[index];

  final InventoryPurchaseOrdersRepository repository;
  InventoryPurchaseOrderImportController({@required this.repository})
      : assert(repository != null);

  final String id = '';
  final isBusy = true.obs;
  final isExpandedVendor = false.obs;
  var result = Rx<PurchaseOrder>();
  var products = List<Product>().obs;
  final vendor = Rx<Vendor>();
  final stock = Rx<Stock>();

  void getId(String purchaseOrderId) {
    print(purchaseOrderId);
    print('run import');
    isBusy(true);
    repository.getId(purchaseOrderId).then((data) {
      print('return data import');
      result.value = data;

      vendor.value = result.value.vendors
          .where((element) => element.id == result.value.vendorId)
          .first;
      stock.value = result.value.stocks
          .where((element) => element.id == result.value.inStockId)
          .first;
      products(result.value.products);
      for (var item in result.value.products) {
        _key.add(GlobalKey());
      }
      isBusy(false);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  void getId2(String purchaseOrderId) {
    repository.getId(purchaseOrderId).then((data) {
      print('return data import');
      result.value = data;
      vendor.value = result.value.vendors
          .where((element) => element.id == result.value.vendorId)
          .first;
      stock.value = result.value.stocks
          .where((element) => element.id == result.value.inStockId)
          .first;
      products(result.value.products);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    });
  }

  void setExpandedVendor(bool value) {
    isExpandedVendor(value);
  }

  save() async {
    var data = await repository.nhanHang(result.value);
    if (data.toString().isEmpty) {
      UI.showSuccess('Đã tạo thành công');
      return true;
    } else {
      UI.showError(data.toString());
      return false;
    }
  }

  void setInQty(int index, int newValue) {
    print('setInQty  at $index change to $newValue');
    var product = products[index];
    product.inQty = newValue;

    product.qtyImportedTextEditingController.text = newValue.toString();
    products[index] = product;
  }

  void setChecked(int index, bool value) {
    var product = products[index];
    product.inQty = value == true ? product.orderQty : 0;

    print(' set checked $value ${product.inQty}');
    products[index] = product;
  }

  getProductImported() {
    return products.where((e) => e.inQty > 0).length;
  }

  getQtyImported() {
    int result = 0;
    for (var product in products) {
      if (product.inQty > 0) result += product.inQty;
    }
    return result;
  }

  int getCountSelectedProduct() {
    return result.value.products
        .where((element) => element.checked == true)
        .length;
  }

  getTotalMoneyImported() {
    int result = 0;
    for (var product in products) {
      if (product.inQty > 0) result += product.inQty * product.orderPrice;
    }
    return result;
  }
}
