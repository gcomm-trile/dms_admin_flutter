import 'dart:developer';
import 'package:dms_admin/Data/api_helper.dart';
import 'package:dms_admin/Data/model/store.dart';
import 'package:dms_admin/Models/dashboard_activity.dart';

import 'package:dms_admin/share/load_status.dart';
import 'package:get/state_manager.dart';

class StoreDetailController extends GetxController {
  var data = Store().obs;

  var isLoading = LoadStatus.success.obs;

  String storeId;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    if (storeId != null) {
      isLoading(LoadStatus.loading);
      API_HELPER.getStore(storeId).then((value) {
        data.value = value;
        if (value == null) {
          log('value null');
        } else {
          log('value is not null ' + value.name);
        }
        isLoading(LoadStatus.success);
      }, onError: (error, stackTrace) {});
    }
  }

  void setStoreId(String _storeId) {
    storeId = _storeId;
    fetchData();
  }
}
