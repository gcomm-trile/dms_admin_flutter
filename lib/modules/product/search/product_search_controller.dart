import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/repository/product_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ProductSearchController extends GetxController {
  final ProductRepository repository;
  ProductSearchController({@required this.repository})
      : assert(repository != null);
  final isBusy = true.obs;

  var result = Rx<List<Product>>();

  void getAll() {
    isBusy(true);
    repository.getAll().then((data) {
      result(data);
      isBusy(false);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
    super.onInit();
  }

  int countChecked() {
    return result.value == null
        ? 0
        : result.value.where((element) => element.checked == true).length;
  }

  void setChecked(Product product) {
    isBusy(true);
    var a = result;
    for (var item in a.value) {
      if (item.id == product.id) {
        item.checked = !product.checked;
      }
    }

    result(a.value);
    isBusy(false);
  }

  Set<Product> getSelectedProduct() {
    return result.value.where((element) => element.checked == true).toSet();
  }
}
