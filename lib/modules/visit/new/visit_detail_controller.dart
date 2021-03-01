import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/data/repository/visit_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VisitDetailController extends GetxController {
  final VisitRepository repository;
  final isBusy = true.obs;
  Rx<Visit> result = Rx<Visit>();
  VisitDetailController({@required this.repository})
      : assert(repository != null);

  getId(String id) {
    isBusy.value = true;
    repository.getId(id).then((data) {
      result.value = data;
      isBusy.value = false;
    });
  }
}
