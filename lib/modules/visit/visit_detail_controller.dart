import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/data/repository/visit_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VisitDetailController extends GetxController {
  final VisitRepository repository;
  VisitDetailController({@required this.repository})
      : assert(repository != null);

  final _visit = Visit().obs;
  Visit get visit => this._visit.value;
  set visit(value) => this._visit.value = value;

  getId(id) {
    repository.getId(id).then((data) {
      visit = data;
    });
  }
}
