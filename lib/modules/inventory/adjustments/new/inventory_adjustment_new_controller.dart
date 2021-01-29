import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/adjustment_model.dart';
import 'package:dms_admin/data/model/category_model.dart';
import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/model/stock.dart';
import 'package:dms_admin/data/repository/inventory_adjustments_repository.dart';
import 'package:dms_admin/global_widgets/number_in_dec/number_increment_decrement.dart';
import 'package:dms_admin/modules/product/search/product_search_dialog.dart';
import 'package:dms_admin/routes/app_pages.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryAdjustmentNewController extends GetxController {
  List<GlobalKey<NumberInputWithIncrementDecrementState>> _key =
      List<GlobalKey<NumberInputWithIncrementDecrementState>>();
  GlobalKey<NumberInputWithIncrementDecrementState> getKey(int index) =>
      _key[index];

  final InventoryAdjustmentsRepository repository;

  InventoryAdjustmentNewController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  var isNew = true;
  var result = AdjustmentItemModel();
  var products = <Product>[].obs;
  final stock = Rx<Stock>();
  final stocks = <String>[].obs;
  final adjustmentReason = Rx<CategoryModel>();

  void getId(String id) {
    isBusy(true);
    repository.getId(id).then((data) {
      result = data;
      if (result.adjustment == null ||
          result.adjustment.id == null ||
          result.adjustment.id == TextHelper.getDefaultGuidString()) {
        result.adjustment = new AdjustmentModel();
        result.adjustment.id = id;
        result.adjustment.products = <Product>[];
        isNew = true;
      } else {
        isNew = false;
        products(result.adjustment.products);
      }

      for (var product in products) {
        _key.add(GlobalKey());
      }
      for (var item in result.stocks) {
        stocks.add(item.name);
      }

      if (isNew == true) {
        stock(result.stocks[0]);
        adjustmentReason(result.adjustmentReasons[0]);
      } else {
        stock(result.stocks
            .where((element) => element.id == result.adjustment.inStockId)
            .first);
        adjustmentReason(result.adjustmentReasons
            .where((element) => element.id == result.adjustment.reasonId)
            .first);
      }

      result.adjustment.id = id;
      isBusy(false);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  addProducts() {
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
                _key.add(GlobalKey());
                print('--------' + products.length.toString());
              }
            }
          },
        ),
      ),
    );
  }

  removeProduct(Product product, int index) {
    var x = products.where((element) => element.id != product.id).toList();
    products(x);
    _key.removeAt(index);
  }

  void save() {
    if (products == null || products.length == 0) {
      UI.showError('Danh sách sản phẩm trống');
      return;
    } else {
      result.adjustment.products = products;
    }

    if (stock.value == null || stock.value.id == null) {
      UI.showError('Chọn kho cần điều chỉnh');
      return;
    } else {
      result.adjustment.inStockId = stock.value.id;
      print('stock id ' + result.adjustment.inStockId);
    }
    print('reason ' + adjustmentReason.value.id.toString());
    result.adjustment.reasonId = adjustmentReason.value.id;

    repository.dieuchinh(result.adjustment).then((data) {
      print(data);
      if (data.toString().isEmpty) {
        Get.offAndToNamed(Routes.INVENTORY_ADJUSTMENTS);
        UI.showSuccess('Đã cập nhật thành công');
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
