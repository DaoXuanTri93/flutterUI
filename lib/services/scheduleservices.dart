import 'package:get/get.dart';
import 'package:login_app/global-variable/globals.dart' as globals;
import 'package:login_app/services/homeProviders.dart';


class ScheduleServices {
  registerSchedule(Map data) async{
    final token = globals.token;
    Response response = await HomeProviders().registerSchedule(token, data);
    if (response.statusCode != 201) {
      Get.snackbar("Đăng kí đi trễ thất bại", response.body["message"]);
      return false;
    }
    Get.snackbar("Đăng kí đi trễ thành công","");
    return false;
  }
}