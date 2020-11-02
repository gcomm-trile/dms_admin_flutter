import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/data/repository/visit_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VisitController extends GetxController {
  final VisitRepository repository;
  VisitController({@required this.repository}) : assert(repository != null);

  final _visitList = List<Visit>().obs;
  get visitList => this._visitList.value;
  set visitList(value) => this._visitList.value = value;

  getAll() {
    print('visit get all');
    repository.getAll().then((data) {
      this.visitList = data;
    }).catchError((onError) => {print(onError.toString())});
  }
}
