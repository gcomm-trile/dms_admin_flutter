import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/adjustment_model.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/repository/inventory_adjustments_repository.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryAdjustmentsController extends GetxController {
  final InventoryAdjustmentsRepository repository;
  InventoryAdjustmentsController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  var result = Rx<List<AdjustmentModel>>();

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

  updateDataByFilterChange(FilterDataChange filterDataChange) {
    refreshData(filterDataChange);
  }
}
