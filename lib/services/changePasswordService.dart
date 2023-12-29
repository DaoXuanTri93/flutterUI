
import 'package:get/get.dart';
import 'package:login_app/const/const.dart';

class ChangePasswordService extends GetConnect{

  Future<Response> changePassword(Map<String, dynamic> data, String token) async =>
      await post('$SEVERNAME/auth/changePassword', data, headers: {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      });
}