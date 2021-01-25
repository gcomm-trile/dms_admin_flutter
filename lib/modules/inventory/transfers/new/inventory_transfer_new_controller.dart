import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/product.dart';

import 'package:dms_admin/data/model/transfer.dart';
import 'package:dms_admin/data/repository/inventory_transfers_repository.dart';
import 'package:dms_admin/modules/product/search/product_search_dialog.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryTransferNewController extends GetxController {
  final InventoryTransfersRepository repository;

  TextEditingController thongTinGhiChuTextEditController =
      TextEditingController();
  TextEditingController soThamChieuTextEditController = TextEditingController();
  InventoryTransferNewController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  final isExpandedVendor = false.obs;
  final note = ''.obs;
  var result = Rx<Transfer>();
  var planImportDate = DateTime.now().obs;
  var products = <Product>[].obs;

  final selectedOutStock = ''.obs;
  final selectedInStock = ''.obs;

  final outStocks = <String>[].obs;
  final inStocks = <String>[].obs;

  void getId(String id) {
    isBusy(true);
    repository.getId(id).then((data) {
      result.value = data;
      thongTinGhiChuTextEditController =
          TextEditingController(text: result.value.note);
      soThamChieuTextEditController =
          TextEditingController(text: result.value.refDocumentNote);
      result.value.id = id;
      if (result.value.products != null) {
        products(result.value.products);
      }

      for (var item in result.value.outStocks) {
        outStocks.add(item.name);
      }

      if (result.value.outStockName == null) {
        print('1');
        selectedOutStock(outStocks[0]);
      } else {
        selectedOutStock(result.value.outStockName);
      }

      for (var item in result.value.inStocks) {
        if (item.name != selectedOutStock.value) inStocks.add(item.name);
      }
      if (result.value.inStockName == null) {
        selectedInStock(inStocks[0]);
      } else {
        selectedInStock(result.value.inStockName);
      }

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
          stockIdIn: result.value.inStocks
              .where((element) => element.name == selectedInStock.value)
              .first
              .id,
          stockIdOut: result.value.outStocks
              .where((element) => element.name == selectedOutStock.value)
              .first
              .id,
          savedData: (selectedProducts) {
            print('return data ' + selectedProducts.length.toString());

            for (var selectedProduct in selectedProducts) {
              if (products
                      .where((element) => element.id == selectedProduct.id)
                      .length ==
                  0) {
                selectedProduct.qtyOrder = 1;
                selectedProduct.qtyIn = 0;
                selectedProduct.qtyOut = 1;
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
      UI.showError('Chọn sản phẩm cần điều chuyển');
      return;
    } else {
      result.value.products = products;
    }
    result.value.inStockId = result.value.inStocks
        .where((element) => element.name == selectedInStock.value)
        .first
        .id;
    result.value.outStockId = result.value.outStocks
        .where((element) => element.name == selectedOutStock.value)
        .first
        .id;
    result.value.planDate = planImportDate.value;
    result.value.refDocumentNote = soThamChieuTextEditController.text;
    result.value.note = thongTinGhiChuTextEditController.text;

    repository.add(result.value).then((data) {
      print(data);
      if (data.toString().isEmpty) {
        UI.showSuccess('Đã tạo thành công');
        Get.offAndToNamed(Routes.INVENTORY_TRANSFERS);
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
            'id: ${product.id} qtyIn: ${product.qtyIn} qtyOut:${product.qtyOut} totalPriceImported:${product.totalPriceAvg}');
      }
    } else {
      print('product null');
    }
  }

  getTotalMoneyOrder() {
    int result = 0;
    for (var product in products) {
      if (product.qtyOrder > 0) result += product.qtyOrder * product.priceOrder;
    }
    return result;
  }

  setStockExport(String value) {
    print('call setStockExport');
    var oldValue = selectedInStock.value;
    inStocks.clear();

    selectedOutStock(value);
    for (var item in result.value.outStocks) {
      if (item.name != selectedOutStock.value) inStocks.add(item.name);
    }
    if (!inStocks.contains(oldValue)) {
      print('!contains');
      print('set ' + inStocks[0]);
      selectedInStock(inStocks[0]);
    } else {
      print('contains');
      selectedInStock(oldValue);
    }
  }

  void setStockImport(String newValue) {
    selectedInStock(newValue);
  }

  void setQtyOut(int index, int value) {
    var item = products[index];
    print('set qty_out at index $index value $value');
    item.qtyOut = value;
    products[index] = item;
  }

  getQtyOut() {
    if (products == null) return 0;
    return (products == null || products.length == 0)
        ? 0
        : products.fold(
            0, (previousValue, element) => previousValue + element.qtyOut);
  }
}
