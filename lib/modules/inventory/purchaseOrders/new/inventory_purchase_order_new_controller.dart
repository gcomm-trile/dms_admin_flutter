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

class InventoryPurchaseOrderNewController extends GetxController {
  final InventoryPurchaseOrderRepository repository;

  TextEditingController thongTinGhiChuTextEditController =
      TextEditingController();
  TextEditingController soThamChieuTextEditController = TextEditingController();
  InventoryPurchaseOrderNewController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  final isExpandedVendor = false.obs;
  final note = ''.obs;
  Rx<PurchaseOrder> result = Rx<PurchaseOrder>();
  Rx<DateTime> planImportDate = DateTime.now().obs;
  var products = <Product>[].obs;
  final vendor = Rx<Vendor>();
  final stock = Rx<Stock>();

  void getId(String id) {
    print('run');
    isBusy(true);
    repository.getId(id).then((data) {
      if (data == null) {
        var item = new PurchaseOrder(id: id, products: List<Product>());
        result.value = item;
      } else {
        result.value = data;
        thongTinGhiChuTextEditController =
            TextEditingController(text: result.value.note);
        soThamChieuTextEditController =
            TextEditingController(text: result.value.refDocumentNote);
      }
      result.value.id = id;
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
    if (result.value.products != null) {
      for (var item in result.value.products) {
        print(item.name + ' ' + item.qtyTextEditingController.text);
      }
    }
    Get.dialog(
      AlertDialog(
        content: ProductSearchDialog(
          stockId: '41B6F379-2254-462A-8472-1C08A4D6D3B2',
          savedData: (selectedProducts) {
            print('return data ' + selectedProducts.length.toString());

            for (var selectedProduct in selectedProducts) {
              if (products
                      .where((element) => element.id == selectedProduct.id)
                      .length ==
                  0) {
                selectedProduct.qtyOrder = 1;
                selectedProduct.priceOrder = 0;
                selectedProduct.totalPriceAvg = 0;
                products.add(selectedProduct);
              }
            }
          },
        ),
      ),
    );
  }

  removeProduct(Product product) {
    print('remove ' +
        product.name.toString() +
        product.qtyTextEditingController.text);
    products.removeWhere((element) => element.id == product.id);
  }

  int getCountSelectedProduct() {
    return result.value.products
        .where((element) => element.checked == true)
        .length;
  }

  void save() {
    if (products == null || products.length == 0) {
      UI.showError('Chọn sản phẩm cần mua hàng');
      return;
    } else {
      result.value.products = products;
      // for (var product in result.value.products) {
      //   print('${product.id} : ${product.qtyOrder} - ${product.priceImported}');
      //   product.qtyOrder = int.parse(product.qtyTextEditingController.text);
      //   product.priceImported =
      //       int.parse(product.priceTextEditingController.text);
      // }
      for (var product in result.value.products) {
        print('${product.id} : ${product.qtyOrder} - ${product.priceOrder}');
      }
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
    result.value.planImportDate = planImportDate.value;
    result.value.refDocumentNote = soThamChieuTextEditController.text;
    result.value.note = thongTinGhiChuTextEditController.text;
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

  void setPriceImported(int index, String value) {
    int price = 0;
    if (value == null || value.isEmpty)
      price = 0;
    else
      price = int.parse(value.replaceAll(',', ''));
    var item = products[index];
    item.priceOrder = price;
    item.totalPriceAvg = item.qtyOrder * item.priceOrder;
    products[index] = item;
  }

  void setQtyOrder(int index, int value) {
    var item = products[index];

    print('set QtyOrder at index $index value $value');
    item.qtyOrder = value;
    item.totalPriceAvg = item.qtyOrder * item.priceOrder;
    products[index] = item;
    print(item.qtyOrder);
    printAllProduct();
  }

  printAllProduct() {
    if (products != null) {
      for (var product in products) {
        print(
            'id: ${product.id} qtyImported: ${product.qtyImported} priceImported:${product.priceOrder} totalPriceImported:${product.totalPriceAvg}');
      }
    } else {
      print('product null');
    }
  }

  getProductOrder() {
    printAllProduct();
    print('call getProductImported');
    return products.where((e) => e.qtyOrder > 0).length;
  }

  getQtyOrder() {
    int result = 0;
    for (var product in products) {
      if (product.qtyOrder > 0) result += product.qtyOrder;
    }
    return result;
  }

  getTotalMoneyOrder() {
    int result = 0;
    for (var product in products) {
      if (product.qtyOrder > 0)
        result += product.qtyOrder * product.priceOrder;
    }
    return result;
  }
}
