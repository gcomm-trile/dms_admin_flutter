import 'package:dms_admin/data/model/product.dart';
import 'package:dms_admin/data/repository/product_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ProductSearchController extends GetxController {
  final ProductRepository repository;
  ProductSearchController({@required this.repository})
      : assert(repository != null);
  final isBusy = true.obs;

  Rx<List<Product>> result = Rx<List<Product>>();
  getAll() {
    isBusy(true);
    repository.getAll().then((data) {
      print('data loaded ');
      result.value = data;
      print('data loaded ' + result.value.length.toString());
      isBusy(false);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    });
  }

  void setChecked(Product product) {
    product.checked.value = !product.checked.value;
  }
}
