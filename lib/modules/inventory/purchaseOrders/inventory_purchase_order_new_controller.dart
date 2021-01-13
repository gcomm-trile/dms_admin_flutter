import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/model/vendor.dart';
import 'package:dms_admin/data/repository/inventory_purchase_order_repository.dart';
import 'package:dms_admin/modules/product/product_search_page.dart';
import 'package:dms_admin/modules/product/search/product_search_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryPurchaseOrderNewController extends GetxController {
  final InventoryPurchaseOrderRepository repository;

  var usernameEditingController;
  InventoryPurchaseOrderNewController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  final isExpandedVendor = false.obs;
  Rx<PurchaseOrder> result = Rx<PurchaseOrder>();
  Rx<DateTime> planImportDate = DateTime.now().obs;
  final vendor = Rx<Vendor>();
  final stock = Rx<Stock>();

  void getId(String purchaseOrderId) {
    print('run');
    isBusy(true);
    repository.getId(purchaseOrderId).then((data) {
      if (data == null) {
        var item = new PurchaseOrder(
            purchaseOrderId: purchaseOrderId, products: List<Product>());
        result.value = item;
      } else {
        result.value = data;
      }
      isBusy(false);
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  showPopupProduct() {}

  void setExpandedVendor(bool value) {
    isExpandedVendor(value);
  }

  setVendor(String value) {
    print('setVendor =' + value);
    if (value.isEmpty) {
      vendor.value = null;
    } else {
      vendor.value =
          result.value.vendors.where((element) => element.name == value).first;
    }
  }

  getAllVendors() {
    List<String> vendors = List<String>();
    for (var item in result.value.vendors) {
      vendors.add(item.name);
    }
    return vendors;
  }

  getAllStocks() {
    List<String> stocks = List<String>();
    for (var item in result.value.stocks) {
      stocks.add(item.name);
    }
    return stocks;
  }

  setStock(String value) {
    print('setStock =' + value);
    if (value.isEmpty) {
      stock.value = null;
    } else {
      stock.value =
          result.value.stocks.where((element) => element.name == value).first;
    }
  }

  void setPlanImportDate(value) {
    planImportDate.value = value;
  }

  addProducts() {
    Get.dialog(
      AlertDialog(
        content: ProductSearchDialog(
          stockId: '41B6F379-2254-462A-8472-1C08A4D6D3B2',
        ),
      ),
    );
  }
}
