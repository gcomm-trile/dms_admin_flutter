import 'package:dms_admin/data/model/order.dart';
import 'package:dms_admin/data/provider/order_api.dart';
import 'package:dms_admin/global_widgets/filter_widget/filter.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

const baseUrl = SERVER_URL + 'orders';

class OrderRepository {
  final OrderApiClient apiClient;
  OrderRepository({@required this.apiClient});

  getAll(FilterDataChange filterDataChange) {
    return apiClient.getAll(filterDataChange);
  }

  getId(id) async {
    return apiClient.getId(id);
  }

  xuathang(String id) {
    return apiClient.xuathang(id);
  }
}
