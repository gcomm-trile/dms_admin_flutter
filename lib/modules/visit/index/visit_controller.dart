import 'package:dms_admin/Helper/UI.dart';
import 'package:dms_admin/data/model/filter_expression.dart';
import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/data/repository/visit_repository.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';

import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VisitController extends GetxController {
  final VisitRepository repository;
  final isBusy = true.obs;
  Rx<List<Visit>> result = Rx<List<Visit>>();

  VisitController({@required this.repository}) : assert(repository != null);

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
