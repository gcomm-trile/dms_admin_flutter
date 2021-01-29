import 'package:get/get.dart';
import 'package:meta/meta.dart';

class FilterController extends GetxController {
  final _obj = '123'.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
