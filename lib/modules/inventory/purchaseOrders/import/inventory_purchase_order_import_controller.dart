import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/model/vendor.dart';
import 'package:dms_admin/data/repository/inventory_purchase_orders_repository.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryPurchaseOrderImportController extends GetxController {
  final InventoryPurchaseOrdersRepository repository;
  InventoryPurchaseOrderImportController({@required this.repository})
      : assert(repository != null);

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
      isBusy(false);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  void setExpandedVendor(bool value) {
    isExpandedVendor(value);
  }

  void import() {
    repository.nhanHang(result.value).then((data) {
      print(data);
      if (data.toString().isEmpty) {
        UI.showSuccess('Đã cập nhật thành công');
        Get.offAndToNamed(Routes.INVENTORY_PURCHASE_ORDERS);
      } else {
        UI.showError(data.toString());
      }
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    });
  }

  void setImportedQty(int index, int newValue) {
    print('imported qty at $index change to $newValue');
    var product = products[index];
    product.inQty = newValue;

    product.qtyImportedTextEditingController.text = newValue.toString();
    products[index] = product;
  }

  void setChecked(int index, bool value) {
    var product = products[index];
    product.inQty = value == true ? product.orderQty : 0;

    print(product.inQty);
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
      if (product.inQty > 0)
        result += product.inQty * product.orderPrice;
    }
    return result;
  }
}
