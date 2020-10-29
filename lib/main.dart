import 'package:dms_admin/my_app.dart';
import 'package:flutter/material.dart';
import 'package:dms_admin/router.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

void main() {
  GoogleMap.init('AIzaSyCT1bnH6x0wAPaqG7PIdusRiTPNzqLqqeM');
  FluroRouter.setupRouter();

  // Get.put(DashboardTongHopController());
  runApp(MyApp());
}
