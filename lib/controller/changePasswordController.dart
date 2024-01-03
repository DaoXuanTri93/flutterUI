
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:login_app/services/changePasswordService.dart';
import 'package:login_app/global-variable/globals.dart' as globals;

class ChangePasswordController extends GetxController {
  ChangePasswordService changePasswordService = ChangePasswordService();
  var datauser = [].obs;
  var message = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  fetchDatauser(Map<String, dynamic> data) async {
    Response response =
        await changePasswordService.changePassword(data, globals.token);
    if (response.statusCode != 201) {
      message.value = response.body["message"];
      // Get.snackbar("Thông Báo", "Bạn đã nhập sai mật khẩu!!!", backgroundColor: Colors.redAccent, duration: Duration(seconds: 2), colorText: Colors.white);

      return  EasyLoading.showError(message.value);
    }

    Get.snackbar("Thông Báo", "Thay đổi mật khau thành công", backgroundColor: Colors.greenAccent);
    Get.toNamed("/NavigationBarDemo1");

    return EasyLoading.dismiss();
  }
}
