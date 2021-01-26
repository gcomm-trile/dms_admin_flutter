import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/repository/product_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ProductSearchController extends GetxController {
  var searchTextEditController = TextEditingController();
  final ProductRepository repository;
  ProductSearchController({@required this.repository})
      : assert(repository != null) {}
  final isBusy = true.obs;
  var sourceData = List<Product>();
  var searchData = List<Product>().obs;

  void getAll(String stockIdIn, String stockIdOut) {
    isBusy(true);
    repository.getAll(stockIdIn, stockIdOut).then((data) {
      sourceData = data;
      searchData(sourceData);
      searchTextEditController.addListener(() {
        print('search text change ' + searchTextEditController.text);
        searchData(sourceData
            .where((element) => element.name
                .toLowerCase()
                .contains(searchTextEditController.text.trim().toLowerCase()))
            .toList());
      });
      isBusy(false);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
    super.onInit();
  }

  int countChecked() {
    return sourceData == null
        ? 0
        : sourceData.where((element) => element.checked == true).length;
  }

  void setChecked(Product product, bool value) {
    var item = sourceData.where((element) => element.id == product.id).first;
    item.checked = value;

    for (int i = 0; i < searchData.length; i++) {
      if (searchData[i].id == product.id) {
        var item = searchData[i];
        item.checked = value;
        searchData[i] = item;
      }
    }
  }

  Set<Product> getSelectedProduct() {
    return sourceData.where((element) => element.checked == true).toSet();
  }
}
