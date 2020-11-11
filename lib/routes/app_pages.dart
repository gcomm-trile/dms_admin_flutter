import 'package:dms_admin/modules/login/login_binding.dart';
import 'package:dms_admin/modules/login/login_page.dart';
import 'package:dms_admin/modules/order/order_binding.dart';
import 'package:dms_admin/modules/order/order_page.dart';
import 'package:dms_admin/modules/visit/visit_binding.dart';
import 'package:dms_admin/modules/visit/visit_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.VISIT,
      page: () => VisitPage(),
      binding: VisitBinding(),
    ),
    GetPage(
      name: Routes.ORDER,
      page: () => OrderPage(),
      binding: OrderBinding(),
    ),
  ];
}
