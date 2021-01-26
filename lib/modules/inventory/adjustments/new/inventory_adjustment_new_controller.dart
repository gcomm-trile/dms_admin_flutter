import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/adjustment.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/model/vendor.dart';
import 'package:dms_admin/data/repository/inventory_adjustments_repository.dart';
import 'package:dms_admin/modules/product/search/product_search_dialog.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryAdjustmentNewController extends GetxController {
  final InventoryAdjustmentsRepository repository;

  InventoryAdjustmentNewController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  final isExpandedVendor = false.obs;
  final note = ''.obs;
  var result = Rx<Adjustment>();
  Rx<DateTime> planDate = DateTime.now().obs;
  var products = <Product>[].obs;
  final vendor = Rx<Vendor>();
  final stock = Rx<Stock>();
  final stocks = <String>[].obs;

  void getId(String id) {
    isBusy(true);
    repository.getId(id).then((data) {
      if (data == null) {
        var item = new Adjustment(id: id, products: List<Product>());
        result.value = item;
      } else {
        result.value = data;
      }
      for (var item in result.value.stocks) {
        stocks.add(item.name);
      }

      stock(result.value.stocks[0]);
      result.value.id = id;
      isBusy(false);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
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
    stock.value =
        result.value.stocks.where((element) => element.id == value).first;
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
          stockIdOut: TextHelper.getDefaultGuidString(),
          stockIdIn: stock.value == null
              ? TextHelper.getDefaultGuidString()
              : stock.value.id,
          savedData: (selectedProducts) {
            print('return data ' + selectedProducts.length.toString());

            for (var selectedProduct in selectedProducts) {
              if (products
                      .where((element) => element.id == selectedProduct.id)
                      .length ==
                  0) {
                selectedProduct.orderQty = 1;
                selectedProduct.orderPrice = 0;
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

      for (var product in result.value.products) {
        print('${product.id} : ${product.orderQty} - ${product.orderPrice}');
      }
    }

    if (stock.value == null || stock.value.id == null) {
      UI.showError('Chọn kho cần mua hàng');
      return;
    } else {
      result.value.inStockId = stock.value.id;
    }
    print('stock ' + result.value.inStockId);
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

  void setQtyOrder(int index, int value) {
    var item = products[index];

    print('set QtyOrder at index $index value $value');
    item.orderQty = value;
    item.totalPriceAvg = item.orderQty * item.orderPrice;
    products[index] = item;
    print(item.orderQty);
    printAllProduct();
  }

  printAllProduct() {
    if (products != null) {
      for (var product in products) {
        print(
            'id: ${product.id} qtyImported: ${product.inQty} priceImported:${product.orderPrice} totalPriceImported:${product.totalPriceAvg}');
      }
    } else {
      print('product null');
    }
  }

  getProductOrder() {
    printAllProduct();
    print('call getProductImported');
    return products.where((e) => e.orderQty > 0).length;
  }

  getQtyOrder() {
    int result = 0;
    for (var product in products) {
      if (product.orderQty > 0) result += product.orderQty;
    }
    return result;
  }

  getTotalMoneyOrder() {
    int result = 0;
    for (var product in products) {
      if (product.orderQty > 0) result += product.orderQty * product.orderPrice;
    }
    return result;
  }
}
