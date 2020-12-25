
import 'package:dio/dio.dart';
import 'package:dms_admin/utils/constants.dart';
import 'package:meta/meta.dart';

const baseUrl = SERVER_URL + 'login';

class LoginRepository {
  final Dio dio;
  LoginRepository({@required this.dio});

  login(String username, String password) async {
    final jobsListAPIUrl =
        SERVER_URL + 'login?username=$username&password=$password';
    print(jobsListAPIUrl);
    final response = await dio.get(baseUrl,
        queryParameters: {"username": username, "password": password});
    if (response.statusCode == 200) {
      print(response.data);
      dio.options.headers["Session-ID"] = response.data;
      return response.data;
    } else {
      return "";
    }
  }
}
