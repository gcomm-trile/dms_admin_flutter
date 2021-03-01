import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/modules/stock/stock_search_page.dart';
import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/data/repository/order_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class OrderDetailController extends GetxController {
  final OrderRepository repository;
  final isBusy = true.obs;
  Rx<Order> result = Rx<Order>();
  OrderDetailController({@required this.repository})
      : assert(repository != null);

  getId(String id) {
    print('call order id ' + id);
    isBusy.value = true;
    repository.getId(id).then((data) {
      result.value = data;
      isBusy.value = false;
    });
  }

  pickStock() {
    Get.bottomSheet(StockSearchPage());
  }

  approved() {}

  save(String id) async {
    try {
      var data = await repository.xuathang(id);

      if (data.toString().isEmpty) {
        UI.showSuccess('Đã cập nhật thành công');

        return true;
      } else {
        UI.showError(data.toString());
        return false;
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      return false;
    }

    // repository.dieuchinh(result.adjustment).then((data) {
    //   print(data);
    // }).catchError((e) {
    //   print(e.toString());
    //   Get.snackbar('Error', e.toString());
    //   return false;
    // });
  }
}
