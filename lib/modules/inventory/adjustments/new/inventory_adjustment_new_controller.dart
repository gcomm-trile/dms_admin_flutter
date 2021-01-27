import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/adjustment.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
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
  var result = Rx<Adjustment>();
  var products = <Product>[].obs;
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

      products(result.value.products);
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
          outStockId: TextHelper.getDefaultGuidString(),
          inStockId: stock.value == null
              ? TextHelper.getDefaultGuidString()
              : stock.value.id,
          titleInStockQty: 'Tồn',
          exceptProducts: products.toList(),
          savedData: (selectedProducts) {
            for (var selectedProduct in selectedProducts) {
              if (products
                      .where((element) => element.id == selectedProduct.id)
                      .length ==
                  0) {
                selectedProduct.inQty = 1;
                products.add(selectedProduct);
              }
            }
          },
        ),
      ),
    );
  }

  removeProduct(Product product) {
    var x = products.where((element) => element.id != product.id).toList();
    products(x);
    Product.printAllProduct(products.value);
  }

  void save() {
    if (products == null || products.length == 0) {
      UI.showError('Danh sách sản phẩm trống');
      return;
    } else {
      result.value.products = products;
    }

    if (stock.value == null || stock.value.id == null) {
      UI.showError('Chọn kho cần điều chỉnh');
      return;
    } else {
      result.value.inStockId = stock.value.id;
    }

    repository.dieuchinh(result.value).then((data) {
      print(data);
      if (data.toString().isEmpty) {
        UI.showSuccess('Đã cập nhật thành công');
        Get.offAndToNamed(Routes.INVENTORY_ADJUSTMENTS);
      } else {
        UI.showError(data.toString());
      }
    }).catchError((e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    });
  }

  void setInQty(int index, int value) {
    var item = products[index];
    print('set setInQty at index $index value $value');
    item.inQty = value;
    products[index] = item;
  }
}
