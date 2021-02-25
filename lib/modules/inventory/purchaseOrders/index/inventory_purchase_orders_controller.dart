import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/model/purchase_order.dart';
import 'package:dms_admin/data/repository/inventory_purchase_orders_repository.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import '../import/inventory_purchase_order_import.dart';

class InventoryPurchaseOrdersController extends GetxController {
  final InventoryPurchaseOrdersRepository repository;
  InventoryPurchaseOrdersController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  Rx<List<PurchaseOrder>> result = Rx<List<PurchaseOrder>>();

  // void createPurchaseOrder() {
  //   Get.to(InventoryPurchaseOrderNewView(
  //     purchaseOrderId: Guid.newGuid.toString(),
  //   ));
  // }

  void goToDetail(PurchaseOrder data) {
    Get.to(InventoryPurchaseOrderImportPage(
      id: data.id,
    ));
  }

  updateDataByFilterChange(FilterDataChange filterDataChange) {
    refreshData(filterDataChange);
  }

  refreshData(filterDataChange) {
    isBusy(true);
    if (filterDataChange == null)
      filterDataChange = FilterDataChange(
          searchText: '', filterExpressions: <FilterExpression>[]);
    repository.getAll(filterDataChange).then((data) {
      result.value = data;
      isBusy(false);
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    }).catchError((error) => UI.showError(error));
  }
}
