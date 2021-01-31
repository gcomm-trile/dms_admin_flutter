import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/adjustment_model.dart';
import 'package:dms_admin/data/model/filter.dart';
import 'package:dms_admin/data/model/filter_expression.dart';

import 'package:dms_admin/data/repository/inventory_adjustments_repository.dart';
import 'package:dms_admin/modules/inventory/adjustments/new/inventory_adjustment_new_page.dart';
import 'package:dms_admin/utils/text_helper.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class InventoryAdjustmentsController extends GetxController {
  final InventoryAdjustmentsRepository repository;
  InventoryAdjustmentsController({@required this.repository})
      : assert(repository != null);

  final isBusy = true.obs;
  var adjustments = Rx<List<AdjustmentModel>>();
  // var filters = List<Filter>();
  var filterExpressions = List<FilterExpression>();

  @override
  void onInit() {
    super.onInit();
  }

  refresh() {
    isBusy(true);
    repository.getAll(filterExpressions).then((data) {
      adjustments.value = data.adjustments;
      isBusy(false);
      print('return data  123');
    }).catchError((e) {
      Get.snackbar('Error', e.toString());
      isBusy(false);
    }).catchError((error) => UI.showError(error));
  }
  // void goToDetail(AdjustmentModel data) {
  //   Get.to(InventoryAdjustmentNewPage(
  //     id: data.id,
  //   ));
  // }

  // void create() {
  //   Get.to(InventoryAdjustmentNewPage(
  //     id: Guid.newGuid.toString(),
  //   ));
  // }
}
