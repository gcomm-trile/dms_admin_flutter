import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/model/vendor.dart';
import 'package:dms_admin/data/repository/inventory_purchase_order_repository.dart';
import 'package:dms_admin/modules/product/search/product_search_dialog.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryPurchaseOrderImportController extends GetxController {
  final InventoryPurchaseOrderRepository repository;
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
          .where((element) => element.id == result.value.importStockId)
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

  int getCountSelectedProduct() {
    return result.value.products
        .where((element) => element.checked == true)
        .length;
  }

  void save() {
    if (result.value.products == null || result.value.products.length == 0) {
      UI.showError('Chọn sản phẩm cần mua hàng');
      return;
    }

    if (stock.value == null || stock.value.id == null) {
      UI.showError('Chọn kho cần mua hàng');
      return;
    } else {
      result.value.importStockId = stock.value.id;
    }
    if (vendor.value == null || vendor.value.id == null) {
      UI.showError('Chọn nhà cung cấp cần mua hàng');
      return;
    } else {
      result.value.vendorId = vendor.value.id;
    }

    print('stock ' + result.value.importStockId);
    print('vendor ' + result.value.vendorId);
    print('vendor ' + result.value.planImportDate.toString());

    repository.add(result.value).then((data) {
      print(data);
      if (data.toString().isEmpty) {
        UI.showSuccess('Đã tạo thành công');
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
    print('imported qty at ${index} change to $newValue');
    var product = products[index];
    product.qtyImported = newValue;
    product.qtyAfterImport = newValue + product.qtyCurrentStock;

    products[index] = product;
  }

  void setChecked(int index, bool value) {
    var product = products[index];
    product.qtyImported = value == true ? product.qtyOrder : 0;
    product.qtyAfterImport = product.qtyImported + product.qtyCurrentStock;
    print(product.qtyImported);
    products[index] = product;
  }

  getProductImported() {
    return products.where((e) => e.qtyImported > 0).length;
  }

  getQtyImported() {
    int result = 0;
    for (var product in products) {
      if (product.qtyImported > 0) result += product.qtyImported;
    }
    return result;
  }

  getTotalMoneyImported() {
    int result = 0;
    for (var product in products) {
      if (product.qtyImported > 0)
        result += product.qtyImported * product.priceImported;
    }
    return result;
  }
}
