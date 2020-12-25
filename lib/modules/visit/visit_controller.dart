import 'dart:developer';

import 'package:dms_admin/data/model/visit.dart';
import 'package:dms_admin/data/repository/visit_repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class VisitController extends GetxController {
  final VisitRepository repository;
  VisitController({@required this.repository}) : assert(repository != null);

  final _visitList = <Visit>[].obs;
  get visitList => this._visitList;
  set visitList(value) => this._visitList(value);

  final _visit = Visit().obs;
  Visit get visit => this._visit.value;
  set visit(value) => this._visit.value = value;

  getAll() {
    print('visit get all');
    repository.getAll().then((data) {
      this.visitList = data;
    }).catchError((onError) {
      print(onError.toString());
      log(onError.toString());
    });
  }

  getId(id) {
    print('visit get ID');
    repository.getId(id).then((data) {
      visit = data;
    });
  }
}
