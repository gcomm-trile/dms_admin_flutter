import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/product.dart';

import 'package:dms_admin/data/model/transfer.dart';
import 'package:dms_admin/data/repository/inventory_transfers_repository.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/modules/product/search/product_search_dialog.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryTransferNewController extends GetxController {
  final InventoryTransfersRepository repository;
  List<GlobalKey<NumberInputWithIncrementDecrementState>> _key =
      List<GlobalKey<NumberInputWithIncrementDecrementState>>();
  GlobalKey<NumberInputWithIncrementDecrementState> getKey(int index) =>
      _key[index];

  TextEditingController thongTinGhiChuTextEditController =
      TextEditingController();
  TextEditingController soThamChieuTextEditController = TextEditingController();
  InventoryTransferNewController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  final isExpandedVendor = false.obs;
  final note = ''.obs;
  var result = Rx<Transfer>();
  var planDate = DateTime.now().obs;
  var products = <Product>[].obs;
  final selectedOutStock = ''.obs;
  final selectedInStock = ''.obs;

  final outStocks = <String>[].obs;
  final inStocks = <String>[].obs;

  void getId(String id) {
    isBusy(true);
    print('call getId' + id);
    repository.getId(id).then((data) {
      result.value = data;
      result.value.id = id;
      products.clear();
      if (result.value.products != null) {
        products(result.value.products);
        for (var item in products) {
          _key.add(GlobalKey());
        }
      }
      print(result.value.planDate);
      if (result.value.planDate == null ||
          result.value.planDate == DateTime(1)) {
        result.value.planDate = DateTime.now();
      }
      planDate(result.value.planDate);
      outStocks.clear();
      for (var item in result.value.outStocks) {
        outStocks.add(item.name);
      }

      if (result.value.outStockName == null) {
        selectedOutStock(outStocks[0]);
      } else {
        selectedOutStock(result.value.outStockName);
      }
      inStocks.clear();
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

  void setPlanDate(value) {
    planDate.value = value;
  }

  addProducts() {
    Get.dialog(
      AlertDialog(
        content: ProductSearchDialog(
          inStockId: result.value.inStocks
              .where((element) => element.name == selectedInStock.value)
              .first
              .id,
          outStockId: result.value.outStocks
              .where((element) => element.name == selectedOutStock.value)
              .first
              .id,
          exceptProducts: products.toList(),
          savedData: (selectedProducts) {
            for (var selectedProduct in selectedProducts) {
              if (products
                      .where((element) => element.id == selectedProduct.id)
                      .length ==
                  0) {
                selectedProduct.orderQty = 1;
                selectedProduct.inQty = 0;
                selectedProduct.outQty = 1;
                selectedProduct.orderPrice = 0;
                selectedProduct.totalPriceAvg = 0;
                products.add(selectedProduct);
                _key.add(GlobalKey());
              }
            }
          },
        ),
      ),
    );
  }

  removeProduct(int index) {
    products.removeAt(index);
    _key.removeAt(index);
  }

  int getCountSelectedProduct() {
    return result.value.products
        .where((element) => element.checked == true)
        .length;
  }

  save(int status) async {
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
    result.value.planDate = planDate.value;
    result.value.refDocumentNote = soThamChieuTextEditController.text;
    result.value.note = thongTinGhiChuTextEditController.text;

    var data = await repository.add(result.value, status);
    if (data.toString().isEmpty) {
      UI.showSuccess('Đã tạo thành công');
      return true;
    } else {
      UI.showError(data.toString());
      return false;
    }
  }

  void setPriceImported(int index, String value) {
    int price = 0;
    if (value == null || value.isEmpty)
      price = 0;
    else
      price = int.parse(value.replaceAll(',', ''));
    var item = products[index];
    item.orderPrice = price;
    item.totalPriceAvg = item.orderQty * item.orderPrice;
    products[index] = item;
  }

  void setQtyOrder(int index, int value) {
    var item = products[index];

    print('set QtyOrder at index $index value $value');
    item.orderQty = value;
    item.totalPriceAvg = item.orderQty * item.orderPrice;
    products[index] = item;

    printAllProduct();
  }

  printAllProduct() {
    if (products != null) {
      for (var product in products) {
        print(
            'id: ${product.id} qtyIn: ${product.inQty} qtyOut:${product.outQty} totalPriceImported:${product.totalPriceAvg}');
      }
    } else {
      print('product null');
    }
  }

  getTotalMoneyOrder() {
    int result = 0;
    for (var product in products) {
      if (product.orderQty > 0) result += product.orderQty * product.orderPrice;
    }
    return result;
  }

  setOutStock(String value) {
    print('call set Out stock');
    var oldValue = selectedInStock.value;
    inStocks.clear();
    selectedOutStock(value);
    for (var item in result.value.inStocks) {
      if (item.name != selectedOutStock.value) {
        inStocks.add(item.name);
      }
    }
    print(inStocks.length);
    if (!inStocks.contains(oldValue)) {
      selectedInStock(inStocks[0]);
    } else {
      selectedInStock(oldValue);
    }
  }

  void setStockImport(String newValue) {
    selectedInStock(newValue);
  }

  void setQtyOut(int index, int value) {
    var item = products[index];
    print('set qty_out at index $index value $value');
    item.outQty = value;
    products[index] = item;
  }

  getQtyOut() {
    if (products == null) return 0;
    return (products == null || products.length == 0)
        ? 0
        : products.fold(
            0, (previousValue, element) => previousValue + element.outQty);
  }
}
